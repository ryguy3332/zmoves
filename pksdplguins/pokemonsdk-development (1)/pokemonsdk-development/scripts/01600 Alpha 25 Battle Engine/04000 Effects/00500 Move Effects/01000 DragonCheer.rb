module Battle
  module Effects
    # Implement the Dragon Cheer effect
    class DragonCheer < PokemonTiedEffectBase
      # Get the name of the effect
      # @return [Symbol]
      def name
        return :dragon_cheer
      end

      private

      # Transfer the effect to the given pokemon via baton switch
      # @note Baton Pass isn't in gen IX so we have no information as of march 2024 of if it should be transferred.
      # @param with [PFM::Battler] the pokemon switched in
      # @return [Battle::Effects::PokemonTiedEffectBase, nil] the effect to give to the switched in pokemon, nil if there is this effect isn't transferable via baton pass
      def baton_switch_transfer(with)
        return self.class.new(@logic, with)
      end
    end
  end
end
