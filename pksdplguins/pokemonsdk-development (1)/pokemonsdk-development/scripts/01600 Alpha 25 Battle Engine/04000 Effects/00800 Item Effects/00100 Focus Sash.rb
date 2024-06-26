module Battle
  module Effects
    class Item
      class FocusSash < Item
        # Function called when a damage_prevention is checked
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @return [:prevent, Integer, nil] :prevent if the damage cannot be applied, Integer if the hp variable should be updated
        def on_damage_prevention(handler, hp, target, launcher, skill)
          return unless target == @target
          return if target.hp > hp || target.hp != target.max_hp
          return unless launcher && skill

          @show_message = true
          return target.hp - 1
        end

        # Function called after damages were applied (post_damage, when target is still alive)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage(handler, hp, target, launcher, skill)
          return unless @show_message

          @show_message = false
          handler.scene.visual.show_item(target)
          handler.scene.display_message_and_wait(parse_text_with_pokemon(19, 514, target))
          handler.logic.item_change_handler.change_item(:none, true, target)
        end
      end

      register(:focus_sash, FocusSash)
    end
  end
end
