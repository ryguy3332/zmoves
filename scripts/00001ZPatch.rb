module Battle
  # Remove for production (debugging message)
   puts "running"

  class << self
    alias_method :original_next_action, :next_action

    def next_action
      action = original_next_action

      if action == :use_move && @actions.last[1] == :b
        show_text("Z-Power!", bottom_left_x + 400, bottom_left_y + 600)
        user = @battle.actors[0]  # Assuming player is in slot 1 (change if needed)

        # Z-Move logic based on ZMoves.rb
        move_id = @battle.move_to_id(@actions.last[2])  # Get move ID from action

        # Improvement: Use ZMoves.find_z_move to retrieve data
        zmove_data = ZMoves.find_z_move(user.item)  # Find ZMove based on user's held item

        # Handle case where no Z-Move is found for the item
        if zmove_data.nil?
          puts "#{user.name}'s held item has no Z-Move effect!"
          return action  # Continue normal action flow
        end

        # Call Z-Move effect
        zmove_data.effect.call(user, @battle.actors[1], @battle)  # Call Z-Move effect

        # End turn after Z-Move execution
        @actions.pop
      end

      action
    end
  end
end