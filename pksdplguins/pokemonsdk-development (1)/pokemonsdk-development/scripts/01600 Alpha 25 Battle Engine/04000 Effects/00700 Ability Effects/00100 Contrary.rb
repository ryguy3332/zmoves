module Battle
  module Effects
    class Ability
      class Contrary < Ability
        # Function called when a stat_change is about to be applied
        # @param handler [Battle::Logic::StatChangeHandler]
        # @param stat [Symbol] :atk, :dfe, :spd, :ats, :dfs, :acc, :eva
        # @param power [Integer] power of the stat change
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @return [Integer, nil] if integer, it will change the power
        def on_stat_change(handler, stat, power, target, launcher, skill)
          return if target != @target

          if !launcher || launcher.can_be_lowered_or_canceled?
            handler.scene.visual.show_ability(target)
            return -power
          end
          return nil
        end

        # Name of the effect
        # @return [Symbol]
        def name
          return :contrary
        end
      end
      register(:contrary, Contrary)
    end
  end
end
