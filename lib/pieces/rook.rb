# the queen piece, can move horizontally or vertically as many squares as it wants
class Rook < Piece

  def initialize(color, symbol)
    super(color, symbol)
  end

  def valid_move?(initial, final)
    initial[0] == final[0] || initial[1] == final[1]
  end
end
