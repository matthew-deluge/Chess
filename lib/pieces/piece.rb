# Piece class, defines the main charateristics of the pieces on the chessboard
class Piece
  attr_accessor :color, :symbol, :moved, :just_moved

  def initialize(color, symbol)
    @color = color
    @symbol = symbol
    @moved = false
  end

  def valid_move?
    false
  end

  def valid_input?(initial, final)
    final[0] > 0 || final[1] > 0 || final[0] < 9 || final[1] < 9 || initial != final
  end
end
