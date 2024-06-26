module Battle
  module Effects
    class Item
      class EjectButton < Item
        # Function called after damages were applied (post_damage, when target is still alive)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage(handler, hp, target, launcher, skill)
          return if target != @target
          return unless skill && launcher != target && handler.logic.can_battler_be_replaced?(target)
          return if launcher.has_ability?(:sheer_force) && launcher.ability_effect&.activated?
          return if handler.logic.switch_request.any? { |request| request[:who] == target }

          handler.logic.actions.reject! { |a| a.is_a?(Actions::Attack) && a.launcher == target }
          handler.logic.switch_request << { who: target }
          handler.scene.visual.show_item(target)
          handler.logic.item_change_handler.change_item(:none, true, target)
        end
      end
      register(:eject_button, EjectButton)
    end
  end
end
