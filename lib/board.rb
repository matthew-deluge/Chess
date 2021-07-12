# board class, creates a set of nodes and populates them with pieces

require_relative './square'
require_relative './pieces/rook'
require_relative './pieces/king'
require_relative './pieces/bishop'
require_relative './pieces/pawn'
require_relative './pieces/knight'
require_relative './pieces/queen'
require_relative './arrangement'
require_relative './display'

class Board

  include Arrangement, Display
  attr_accessor :node_array, :coord_array, :captured_pieces, :move_array

  def initialize
    @coord_array = create_array(8)
    @node_array = create_board
    @captured_pieces = []
    @move_array = []
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

  def save_file
    board_state = {
      node_array: @node_array,
      captured_pieces: @captured_pieces,
      move_array: @move_array
    }.to_json
    File.open('lib/save_data.json', 'w') { |file| file.write(board_state) }
    puts 'File saved, see you again soon!'
    exit
  end

  def load_file
    file = File.read('lib/save_data.json')
    board_state = JSON.parse(file)
    @node_array = board_state['node_array']
    @captured_pieces = board_state['captured_pieces']
    @move_array = board_state['move_array']
    puts "Welcome back!"
    p board
    board.print_board(board)
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
    return false if piece.nil? || !piece.valid_move?(origin_square, target_square, self)

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
    if find_square(target_coord).piece.nil?
      move_piece(origin_coord, target_coord)
    else
      capture_piece(origin_coord, target_coord)
    end
    find_square(target_coord).piece.moved = true
    move_array.push([origin_coord, target_coord])
  end

  def capture_piece(origin_coord, target_coord)
    capture = find_square(target_coord).piece
    find_square(target_coord).piece = find_square(origin_coord).piece
    find_square(origin_coord).piece = nil
    @captured_pieces.push(capture)
  end

  private

  def move_piece(origin_coord, target_coord)
    find_square(target_coord).piece = find_square(origin_coord).piece
    find_square(origin_coord).piece = nil
  end

end