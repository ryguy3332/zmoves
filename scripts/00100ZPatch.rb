module Battle
  class Pokemon
    alias_method :orig_initialize, :initialize

    def initialize(*args)
      orig_initialize(*args)
      @battle.events.on(:key_press) { |event| attempt_z_move if event.key == :B }
    end

    def attempt_z_move(item)
      if item && Z_MOVES.key?(item.id)
        z_move_data = Z_MOVES[item.id]
        if z_move_data && can_use_z_move?(z_move_data)
          current_move_index = get_selected_move_index
          $game_player.party[get_selected_pokemon_index].moves[current_move_index] = z_move_data
          # Announce Z-Move usage (optional)
          # $game_message.pbMessage(" unleashed its Z-Move!")
        end
      end
    end

    def replace_move_with_z_move(z_move_data)
      # This method is no longer needed as we directly replace the move in attempt_z_move
    end

    def can_use_z_move?(z_move_data)
      # Check if the Pokemon's held item matches the Z-Move's required item
      held_item = $game_player.party[get_selected_pokemon_index].item
      return false unless held_item

      held_item_id = held_item.id
      z_move_item_id = z_move_data[:required_item]  # Assuming required item data is stored in the Z-Move data structure

      held_item_id == z_move_item_id
    end
  end
end