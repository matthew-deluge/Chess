# Piece class, defines the main charateristics of the pieces on the chessboard
class Piece
  attr_accessor :color, :symbol

  def initialize(color, symbol)
    @color = color
    @symbol = symbol
  end

  def valid_move?
    false
  end
end
