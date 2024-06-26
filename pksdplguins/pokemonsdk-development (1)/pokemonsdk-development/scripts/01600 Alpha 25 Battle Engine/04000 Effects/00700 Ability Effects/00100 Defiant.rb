module Battle
  module Effects
    class Ability
      class Defiant < Ability
        # Function called when a stat_change has been applied
        # @param handler [Battle::Logic::StatChangeHandler]
        # @param stat [Symbol] :atk, :dfe, :spd, :ats, :dfs, :acc, :eva
        # @param power [Integer] power of the stat change
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @return [Integer, nil] if integer, it will change the power
        def on_stat_change_post(handler, stat, power, target, launcher, skill)
          return if target != @target || target == launcher
          return if @logic.allies_of(target).include?(launcher)
          return if power >= 0

          handler.scene.visual.show_ability(target)
          handler.logic.stat_change_handler.stat_change_with_process(stat_changed, 2, target)
        end

        # Stat changed by the ability
        # @return [symbol] of the stat
        def stat_changed
          return :atk
        end
      end

      class Competitive < Defiant
        # Stat changed by the ability
        # @return [symbol] of the stat
        def stat_changed
          return :ats
        end
      end
      register(:defiant, Defiant)
      register(:competitive, Competitive)
    end
  end
end
