module Battle
  class Move
    # Class managing the Geomancy move
    # @see https://pokemondb.net/move/geomancy
    class Geomancy < TwoTurnBase
      private

      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          @logic.stat_change_handler.stat_change_with_process(:ats, 2, target, user, self)
          @logic.stat_change_handler.stat_change_with_process(:dfs, 2, target, user, self)
          @logic.stat_change_handler.stat_change_with_process(:spd, 2, target, user, self)
        end
      end
    end
    Move.register(:s_geomancy, Geomancy)
  end
end
