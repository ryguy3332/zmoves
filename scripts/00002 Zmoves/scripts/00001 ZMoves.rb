class ZMove
  # Properties for a Z-Move
  attr_accessor :move, :user_item, :base_power, :effect, :is_contact_move

  def initialize(move:, user_item:, base_power:, effect:, is_contact_move:)
    @move = move
    @user_item = user_item
    @base_power = base_power
    @effect = effect  # Lambda function for custom Z-Move effect
    @is_contact_move = is_contact_move
  end

  # New method to find a ZMove based on user's item
  def self.find_z_move(item)
    # Assuming a Z-Move hash exists (replace with your logic)
    # This hash should map Z-Crystals to their corresponding ZMove objects
    Z_MOVES ||= {}

    # Check if the hash is already populated (optional optimization)
    return Z_MOVES[item] if Z_MOVES.key?(item)

    # Find the ZMove object where user_item matches the given item
    zmove_data = Z_MOVES.values.find { |zmove| zmove.user_item == item }

    # Return the found ZMove or nil if not found
    zmove_data
  end
end