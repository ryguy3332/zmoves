module Battle
  module Effects
    class Item
      class LansatBerry < Berry
        # Function called after damages were applied (post_damage, when target is still alive)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage(handler, hp, target, launcher, skill)
          return if target != @target

          process_effect(target, launcher, skill)
        end

        # Function called at the end of a turn
        # @param logic [Battle::Logic] logic of the battle
        # @param scene [Battle::Scene] battle scene
        # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
        def on_end_turn_event(logic, scene, battlers)
          return unless battlers.include?(@target)
          return if @target.dead?

          process_effect(@target, nil, nil)
        end

        # Function that executes the effect of the berry (for Pluck & Bug Bite)
        # @param force_heal [Boolean] tell if a healing berry should force the heal
        # @param force_execution [Boolean] tell if the execution of the berry has to be forced
        def execute_berry_effect(force_heal: false, force_execution: false)
          define_singleton_method(:hp_rate_trigger) { 1 } if force_heal

          process_effect(@target, nil, nil, force_execution)
        end

        private

        # Function that process the effect of the berry (if possible)
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @param force_execution [Boolean] tell if the execution of the berry has to be forced
        def process_effect(target, launcher, skill, force_execution = false)
          return if target.dead? || target.hp_rate > hp_rate_trigger || target.effects.has?(:lansat_berry)
          return if cannot_be_consumed?(force_execution)

          consume_berry(target, launcher, skill)
          effect = PokemonTiedEffectBase.new(@logic, target)
          effect.define_singleton_method(:name) { :lansat_berry }
          target.effects.add(effect)
        end

        # Give the hp rate that triggers the berry
        # @return [Float]
        def hp_rate_trigger
          return @target.has_ability?(:gluttony) ? 0.5 : 0.25
        end
      end
      register(:lansat_berry, LansatBerry)
    end
  end
end
