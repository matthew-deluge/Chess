# is the different squares on the chess board

class Square
  attr_accessor :piece
  attr_reader :coord

  def initialize(coord, piece)
    @coord = coord
    @piece = piece
  end

  def occupied?
    !@piece == nil
  end

  private
  attr_writer :coordinates

end