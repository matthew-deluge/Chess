# board class, creates a set of nodes and populates them with pieces

require_relative "./square"
require_relative "./pieces/rook.rb"
class Board
  attr_accessor :node_array, :coord_array

  def initialize
    @coord_array = create_array(8)
    @node_array = create_board
  end

  def create_array(n)
    a = Array.new(n) { |index| index + 1  }
    board = []
    a.each do |i|
      a.each do |j|
        board.push([i, j])
      end
    end
    board
  end

  def create_board
    board = []
    @coord_array.each do |coord|
      board.push(Square.new(coord, nil))
    end
    board
  end

  def add_piece(coord, piece)
    node_array.each {|square| square.piece = piece if square.coord == coord}
  end

  def clear_path?(piece, initial_square, final_square)
    path = piece.generate_path(initial_square, final_square)
    print path
    print path[1..-2]
    path[1..-2].each do |coord|
      square = find_square(coord)
      return false unless square.piece.nil?
    end
    true
  end

  private

  def find_square(coord)
    @node_array.each do |square|
      return square if square.coord == coord
    end
  end

end
