module Battle
  class Move
    # Class describing a basic move (damage + potential status + potential stat)
    class Basic < Move
      # Function that deals the damage to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_damage(user, actual_targets)
        return true if status?
        raise 'Badly configured move, it should have positive power' if power < 0

        successful_damages = actual_targets.map do |target|
          hp = damages(user, target)
          damage_handler = @logic.damage_handler
          damage_handler.damage_change_with_process(hp, target, user, self) do
            scene.display_message_and_wait(actual_targets.size == 1 ? parse_text(18, 84) : parse_text_with_pokemon(19, 384, target)) if critical_hit?
            efficent_message(effectiveness, target) if hp > 0
          end
          recoil(hp, user) if recoil? && damage_handler.instance_variable_get(:@reason).nil?
          next false if damage_handler.instance_variable_get(:@reason)

          next true
        end
        new_targets = actual_targets.map.with_index { |target, index| successful_damages[index] && target }.select { |target| target }
        actual_targets.clear.concat(new_targets)
        return successful_damages.include?(true)
      end

      # Test if the effect is working
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [Boolean]
      def effect_working?(user, actual_targets)
        if !status? && user.can_be_lowered_or_canceled?(target = actual_targets.find { |t| t.has_ability?(:shield_dust) })
          @scene.visual.show_ability(target) if data.effect_chance > 0 && target.alive?
          return false
        end

        n = 1
        scene.logic.each_effects(user).each do |e|
          n *= e.effect_chance_modifier(self)
        end

        return bchance?((effect_chance * n) / 100.0) && super # super ensure that the magic_bounce & magic_coat effect works
      end
    end

    # Class describing a basic move (damage + status + stat = garanteed)
    class BasicWithSuccessfulEffect < Basic
      # Test if the effect is working
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [Boolean]
      def effect_working?(user, actual_targets)
        exec_hooks(Move, :effect_working, binding)
        return true
      end
    end

    Move.register(:s_basic, Basic)
  end
end
