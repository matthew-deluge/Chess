# board class, creates a set of nodes and populates them with pieces

require_relative './square'
require_relative './pieces/rook'
require_relative './pieces/king'
require_relative './arrangement'
require_relative './display'

class Board

  include Arrangement, Display
  attr_accessor :node_array, :coord_array, :captured_pieces

  def initialize
    @coord_array = create_array(8)
    @node_array = create_board
    @captured_pieces = []
  end

  def create_array(n)
    a = Array.new(n) { |index| index + 1 }
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

  def print_board_data
    @node_array.each do |square|
      print square.coord
      print ":"
      unless square.piece.nil?
        print "#{square.piece.symbol}"
      end
      print "\n"
    end
  end

  def set_pieces
    Arrangement::SET_UP_HASH.each do |piece|
      add_piece(piece[:coord], piece[:piece])
    end
  end

  def find_square(coord)
    @node_array.each { |square| return square if square.coord == coord }
  end

  def add_piece(coord, piece)
    node_array.each { |square| square.piece = piece if square.coord == coord}
  end

  def copy_board
    new_board = Board.new
    node_array.each do |old_square|
      next if old_square.piece.nil?

      new_board.node_array.each do |new_square|
        if old_square.coord == new_square.coord
          new_square.piece = old_square.piece.duplicate
        end
      end
    end
    new_board
  end
  
  def clear_path?(origin_square, target_square)
    piece = find_square(origin_square).piece
    return false if piece.nil?

    target_piece = find_square(target_square).piece
    unless target_piece.nil?
      return false if target_piece.color == piece.color
    end

    path = piece.generate_path(origin_square, target_square)
    path[1..-2].each do |coord|
      square = find_square(coord)
      return false unless square.piece.nil?
    end
    true
  end

  def move(origin_coord, target_coord)
    return unless clear_path?(origin_coord, target_coord)

    if find_square(target_coord).piece.nil?
      move_piece(origin_coord, target_coord)
    else
      capture_piece(origin_coord, target_coord)
    end
  end

private

  def move_piece(origin_coord, target_coord)
    find_square(target_coord).piece = find_square(origin_coord).piece
    find_square(origin_coord).piece = nil
  end

  def capture_piece(origin_coord, target_coord)
    capture = find_square(target_coord).piece
    find_square(target_coord).piece = find_square(origin_coord).piece
    find_square(origin_coord).piece = nil
    @captured_pieces.push(capture)
  end
end