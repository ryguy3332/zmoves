module Battle
  module Effects
    class Ability
      class GorillaTactics < Ability
        # Give the move [Spe]atk mutiplier
        # @param user [PFM::PokemonBattler] user of the move
        # @param target [PFM::PokemonBattler] target of the move
        # @param move [Battle::Move] move
        # @return [Float, Integer] multiplier
        def sp_atk_multiplier(user, target, move)
          return 1 if user != @target

          return move.physical? ? 1.5 : 1
        end

        # Function called when we try to use a move as the user (returns :prevent if user fails)
        # @param user [PFM::PokemonBattler]
        # @param targets [Array<PFM::PokemonBattler>]
        # @param move [Battle::Move]
        # @return [:prevent, nil] :prevent if the move cannot continue
        def on_move_prevention_user(user, targets, move)
          return if can_be_used?(user, move)

          move.show_usage_failure(user)
          return :prevent
        end

        # Function called when we try to check if the user cannot use a move
        # @param user [PFM::PokemonBattler]
        # @param move [Battle::Move]
        # @return [Proc, nil]
        def on_move_disabled_check(user, move)
          return if can_be_used?(user, move)

          return proc {
            move.scene.visual.show_ability(user)
            move.scene.display_message_and_wait(parse_text_with_pokemon(19, 911, user, PFM::Text::MOVE[1] => move.name))
          }
        end

        private

        # Checks if the user can use the move
        # @param user [PFM::PokemonBattler]
        # @param move [Battle::Move]
        # @return [Boolean]
        def can_be_used?(user, move)
          last_move = user.move_history.reject { |move| move.db_symbol == :struggle }.last

          return true if user != @target
          return true if user.move_history.none?
          return true if move.db_symbol == :struggle
          return true if last_move.db_symbol == move.db_symbol
          return true if last_move.turn < user.last_sent_turn

          return false
        end
      end

      register(:gorilla_tactics, GorillaTactics)
    end
  end
end
