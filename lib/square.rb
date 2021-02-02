# is the different squares on the chess board

class Square
  attr_accessor :piece
  attr_reader :coordinates

  def initialize(coordinates, piece)
    @coordinates = coordinates
    @current_piece = piece
  end

  def occupied?
    !@current_piece == nil
  end

  private
  attr_writer :coordinates

end