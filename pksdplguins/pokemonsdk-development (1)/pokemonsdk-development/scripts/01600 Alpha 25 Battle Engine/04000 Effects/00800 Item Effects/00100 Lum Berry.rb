module Battle
  module Effects
    class Item
      class LumBerry < Berry
        # Function called when a post_status_change is performed
        # @param handler [Battle::Logic::StatusChangeHandler]
        # @param status [Symbol] :poison, :toxic, :confusion, :sleep, :freeze, :paralysis, :burn, :flinch, :cure
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_status_change(handler, status, target, launcher, skill)
          return if target != @target || status == :cure || status == :flinch

          process_effect(@target, launcher, skill)
        end

        # Function that executes the effect of the berry (for Pluck & Bug Bite)
        # @param force_heal [Boolean] tell if a healing berry should force the heal
        # @param force_execution [Boolean] tell if the execution of the berry has to be forced
        def execute_berry_effect(force_heal: false, force_execution: false)
          process_effect(@target, nil, nil, force_execution)
        end

        private

        # Function that process the effect of the berry (if possible)
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @param force_execution [Boolean] tell if the execution of the berry has to be forced
        def process_effect(target, launcher, skill, force_execution = false)
          return if target.dead?
          return if cannot_be_consumed?(force_execution)

          consume_berry(target, launcher, skill)
          return unless launcher && skill

          @logic.status_change_handler.status_change(:confuse_cure, target, launcher, skill) if target.confused?
          @logic.status_change_handler.status_change(:cure, target, launcher, skill) if target.status?
        end
      end
      register(:lum_berry, LumBerry)
    end
  end
end
