class Game_Player
  # List of system tags that makes the player Jump
  JumpTags = [JumpL, JumpR, JumpU, JumpD]

  # Move or turn the player according to its input. The common event 2 can be triggered there
  # @author Nuri Yuri
  def player_update_move
    # mouse_input = Input.kpress?(1)
    # Turn on itself system
    @wturn = 10 - @move_speed if @lastdir4 == 0 && !(Input.repeat?(:UP) || Input.repeat?(:DOWN) ||
                                 Input.repeat?(:LEFT) || Input.repeat?(:RIGHT))

    @lastdir4 = Input.dir4 # (mouse_input ? mouse_dir4 : Input.dir4)
    swamp_detect = (@in_swamp and @in_swamp > 4)
    if bool = ((@wturn > 0) | swamp_detect)
      player_turn(swamp_detect)
    else
      player_move
    end

    player_update_move_bump(bool)
    player_update_move_common_events(bool)
  end

  # Turn the player on himself. Does some calibration for the Acro Bike.
  # @author Nuri Yuri
  def player_turn(swamp_detect)
    if swamp_detect && @lastdir4 != @direction && @lastdir4 != 0
      @in_swamp -= 1
    end
    last_dir = @direction
    case @lastdir4
    when 2
      turn_down
    when 4
      turn_left
    when 6
      turn_right
    when 8
      turn_up
    else
      if system_tag == Hole
        $game_temp.common_event_id = Game_CommonEvent::HOLE_FALLING
      elsif @on_acro_bike
        update_acro_bike_turn(system_tag)
      end
    end
    calibrate_acro_direction(last_dir)
  end

  # Move the player. Does some calibration for the Acro Bike.
  # @author Nuri Yuri
  def player_move
    #> gestion du vélo cross
    jumping = false
    jumping_dist = 1
    if @acro_bike_bunny_hop
      return if (jumping = update_acro_bike(5, front_system_tag)) == false
      jumping_dist = 2 if JumpTags.include?(front_system_tag)
    end
    last_dir = @direction
    case @lastdir4
    when 2
      jumping ? jump(0, jumping_dist) : move_down
    when 4
      turn_left
      jumping ? jump(-jumping_dist, 0) : move_left
    when 6
      turn_right
      jumping ? jump(jumping_dist, 0) : move_right
    when 8
      jumping ? jump(0, -jumping_dist) : move_up
    #else
      #@cant_bump=true
    end
    calibrate_acro_direction(last_dir)
    update_cycling_state if @state == :cycle_stop && moving?
  end

  # Reset the direction of the player when he's on bike bridge
  # @param last_dir [Integer] the last direction
  # @author Nuri Yuri
  def calibrate_acro_direction(last_dir)
    if @__bridge && (sys_tag = @__bridge.first)
      return if sys_tag != AcroBikeRL && sys_tag != AcroBikeUD
    end
    case @direction
    when 8, 2
      @direction = last_dir if sys_tag == AcroBikeRL
    when 4, 6
      @direction = last_dir if sys_tag == AcroBikeUD
    end
  end

  # Update the Acro Bike jump info
  # @param count [Integer] number of @acro_count frame before the player is allowed to jump
  # @param sys_tag [Integer] the current system tag
  # @return [Boolean, nil] if the player can jump (nil = not allowed to jump but can move forward)
  # @author Nuri Yuri
  def update_acro_bike(count, sys_tag)
    return false if jumping?
    if SlideTags.include?(sys_tag) or sys_tag == MachBike
      return nil
    end
    if @wturn == 0 && !$game_map.jump_passable?(@x, @y, @lastdir4)
      return nil if system_tag != AcroBike && !@__bridge
    end
    if @acro_count < count
      @acro_count += 1
      return false
    end
    @acro_count = 0
    return true
  end

  # Update the Acro Bike jump info when not moving
  # @param count [Integer] number of @acro_count frame before the player is allowed to jump
  # @param sys_tag [Integer] the current system tag
  # @return [Boolean, nil] if the player can jump (nil = not allowed to jump but can move forward)
  # @author Leikt
  def update_acro_bike_turn(sys_tag)
    if sys_tag == AcroBike
      if @bunny_bike_forced.nil?
        @bunny_bike_forced = $game_switches[::Yuki::Sw::CantLeaveBike]
        $game_switches[::Yuki::Sw::CantLeaveBike] = true
      end
      if update_acro_bike(5, sys_tag)
        jump(0,0)
      end
    elsif Input.press?(:B)
      unless @bunny_bike_forced.nil?
        $game_switches[::Yuki::Sw::CantLeaveBike] = @bunny_bike_forced
        @bunny_bike_forced = nil
      end
      if update_acro_bike((@acro_bike_bunny_hop ? 5 : 35), sys_tag)
        jump(0,0)
        @acro_bike_bunny_hop = true
      end
    elsif !Input.press?(:B)
      unless @bunny_bike_forced.nil?
        $game_switches[::Yuki::Sw::CantLeaveBike] = @bunny_bike_forced
        @bunny_bike_forced = nil
      end
      @acro_bike_bunny_hop = false
    end
  end

  # Manage the bump part of the player_update_move
  # @param bool [Boolean] tell if the player did a fast direction change
  def player_update_move_bump(bool)
    return player_update_move_bump_restore_step_anime if moving? # No bump while moving

    # No bump if coordinate aren't identic
    if @__last_x != @x || @__last_y != @y
      @__last_x = @x
      @__last_y = @y
      return player_update_move_bump_restore_step_anime
    end

    if @lastdir4 != 0 && !bool # If the direction is set and it's not a fast direction change
      # Store & set step anime to mimic the trying to walk into wall effect
      @__previous_step_anim = @step_anime if @__previous_step_anim.nil?
      @step_anime = true
      if (@__old_pattern == 3 && @pattern == 0) || (@__old_pattern == 1 && @pattern == 2)
        Audio.se_play(BUMP_FILE)
      end
    else
      player_update_move_bump_restore_step_anime
    end

    @__old_pattern = @pattern
  end

  # Restore step anime if it was changed
  def player_update_move_bump_restore_step_anime
    return if @__previous_step_anim.nil?

    @step_anime = @__previous_step_anim
    @__previous_step_anim = nil
  end

  # Manage the common event calling of player_update_move
  # @param bool [Boolean]
  def player_update_move_common_events(bool)
    if @on_acro_bike
      if !@acro_appearence && Input.press?(:B)
        @acro_appearence = true
        enter_in_wheel_state # $game_temp.common_event_id = Game_CommonEvent::APPEARANCE
      elsif @acro_appearence && !Input.press?(:B) && !jumping? &&!@acro_bike_bunny_hop
        @acro_appearence = false
        leave_wheel_state # $game_temp.common_event_id = Game_CommonEvent::APPEARANCE
      end
    else
      player_update_move_running_state(bool) unless @surfing || cycling?
    end
  end

  # Manage the running update of player_update_move inside player_update_move_common_events
  # @param bool [Boolean]
  def player_update_move_running_state(bool)
    # Make the player run
    if !bool && @lastdir4 != 0 && $game_switches[::Yuki::Sw::EV_CanRun] &&
       !$game_switches[::Yuki::Sw::EV_Run] && Input.press?(:B) && !@step_anime # Test avec bump
      enter_in_running_state unless @state == :sinking # $game_temp.common_event_id = Game_CommonEvent::APPEARANCE
    # Stop to run
    elsif $game_switches[::Yuki::Sw::EV_Run] && (@lastdir4 == 0 || !Input.press?(:B) || $game_system.map_interpreter.running? || @step_anime)
      enter_in_walking_state unless @state == :sinking # $game_temp.common_event_id = Game_CommonEvent::APPEARANCE
    end
  end

  # Update the cracked floor when the player move on it
  def player_move_on_cracked_floor_update
    if (sys_tag = system_tag) == CrackedSoil
      tile_z = 0
      2.downto(0) do |i|
        tile_id = $game_map.data[x, y, i]
        break tile_z = i if $game_map.system_tags[tile_id] == CrackedSoil
      end
      $game_map.data[@x, @y, tile_z] = $game_map.data[@x, @y, tile_z] + 1
      # The player falls if it has not the right speed and it's now a hole
      $game_temp.common_event_id = Game_CommonEvent::HOLE_FALLING if system_tag == Hole && @move_speed < 5
    elsif sys_tag == Hole
      $game_temp.common_event_id = Game_CommonEvent::HOLE_FALLING
    end
  end
end
