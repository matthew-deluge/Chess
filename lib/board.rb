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
    return true if castle_check(origin_square, target_square)
    piece = find_square(origin_square).piece
    return false if piece.nil? || !piece.valid_move?(origin_square, target_square, self)

    target_piece = find_square(target_square).piece
    return false if !target_piece.nil? && target_piece.color == piece.color

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
    check_promotion(target_coord)
  end

  def check_promotion(target_coord)
    if find_square(target_coord).piece.is_a?(Pawn) && target_coord[1] == 1 
      promote_pawn(target_coord)
    elsif find_square(target_coord).piece.is_a?(Pawn) && target_coord[1] == 8
      promote_pawn(target_coord)
    end
  end

  def promote_pawn(target_coord, piece = prompt_player)
    square = find_square(target_coord)
    color = square.piece.color
    color == 'white' ? piece_array = Arrangement::WHITE_PIECE_ARRAY : piece_array = Arrangement::BLACK_PIECE_ARRAY
    case piece
    when 'queen'
      square.piece = Queen.new(color, piece_array[5])
    when 'knight'
      square.piece = Knight.new(color, piece_array[1])
    when 'bishop'
      square.piece = Bishop.new(color, piece_array[2])
    when 'rook'
      square.piece = Rook.new(color, piece_array[3])
    end
  end

  def prompt_player
    player_input = ''
    potential_responses = ['queen', 'knight', 'bishop', 'rook']
    until potential_responses.include?(player_input)
      puts 'What piece would you like to promote your pawn to? (type queen, bishop, rook, or knight)'
      player_input = gets.chomp.downcase
    end
    player_input
  end

  def capture_piece(origin_coord, target_coord)
    capture = find_square(target_coord).piece
    find_square(target_coord).piece = find_square(origin_coord).piece
    find_square(origin_coord).piece = nil
    @captured_pieces.push(capture)
  end

  private

  def castle_check(initial_square, target_square)
    piece = find_square(initial_square).piece
    return false unless piece.is_a?(King)

    piece.castle?(initial_square, target_square, self)
  end



  def move_piece(origin_coord, target_coord)
    find_square(target_coord).piece = find_square(origin_coord).piece
    find_square(origin_coord).piece = nil
  end

end