module Battle
  class Move
    class LowKick < Basic
      MAXIMUM_WEIGHT = [10, 25, 50, 100, 200]
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
        target_weight = (target.weight != target.data.weight) ? (user.can_be_lowered_or_canceled? ? target.weight : target.data.weight) : target.weight
        weight_index = MAXIMUM_WEIGHT.find_index { |weight| target_weight < weight } || MAXIMUM_WEIGHT.size
        return 20 + 20 * weight_index
      end
    end

    Move.register(:s_low_kick, LowKick)
  end
end
