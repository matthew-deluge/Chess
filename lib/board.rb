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

end

board = Board.new
print board.coord_array
board.add_piece([1,1], Rook.new('white', 'R'))
print board.node_array

