
require_relative './piece'

# class for the king piece
class King < Piece

  def duplicate
    new_piece = King.new(@color, @symbol)
    new_piece
  end

  def valid_move?(initial, final, board = nil)
    if castle?(initial, final, board)
      castle_move(initial, final, board)
      true
    else
      valid_vertical?(initial,final)||valid_horizontal?(initial,final)||valid_diaganol?(initial, final)
    end
  end

  def generate_path(initial, final)
    [initial, final]
  end

  def check?(king_square, board)
    board.node_array.each do |square|
      next if square.piece.nil?

      unless square.piece.color == @color
        return true if square.piece.valid_move?(square.coord, king_square, board) && board.clear_path?(square.coord, king_square)
      end
    end
    false
  end

  def checkmate?(king_square, board)
    return false unless check?(king_square, board)

    no_available_moves?(king_square, board) && no_escape_path?(king_square, board)
  end

  def castle?(initial, final, board)
    @color == 'white' ? rank = 1 : rank = 8
    return false unless @moved == false

    if final == [7, rank]
      rook = board.find_square([8,rank]).piece
      return false if rook.nil? || rook.moved == true

      bishop_square = board.find_square([6,rank])
      knight_square = board.find_square([7,rank])
      return false unless bishop_square.piece.nil? && knight_square.piece.nil?

      return castle_check?([[7,rank], [6,rank]], rank, board)

    elsif final == [3, rank]
      rook = board.find_square([1,rank]).piece
      return false if rook.nil? || rook.moved == true

      bishop_square = board.find_square([2,rank])
      knight_square = board.find_square([3,rank])
      queen_square = board.find_square([4, rank])
      return false unless bishop_square.piece.nil? && knight_square.piece.nil?&&queen_square.piece.nil?

      return castle_check?([[4, rank], [3,rank]], rank, board)
    end
    false
  end

  def castle_move(initial, final, board)
    @color == 'white' ? rank = 1 : rank = 8

    if final == [7, rank]
      rook = board.find_square([8,rank]).piece
      king = board.find_square(initial).piece
      board.find_square([8,rank]).piece = nil
      board.find_square(initial).piece = nil
      board.find_square(final).piece = king
      board.find_square([6,rank]).piece = rook

    elsif final == [3, rank]
      rook = board.find_square([1,rank]).piece
      king = board.find_square(initial).piece
      board.find_square([1,rank]).piece = nil
      board.find_square(initial).piece = nil
      board.find_square(final).piece = king
      board.find_square([4,rank]).piece = rook
    end
  end

  private

  def castle_check?(squares_to_check, rank, board)
    squares_to_check.each do |square|
      board_copy = board.copy_board
      board_copy.find_square([5, rank]).piece = nil
      test_king = duplicate
      board_copy.add_piece(square, test_king)
      return false if test_king.check?(square, board_copy)
    end
    true
  end

  def no_escape_path?(king_square, board)
    board.node_array.each do |square|
      next unless valid_move?(king_square, square.coord, board) && board.clear_path?(king_square, square.coord)

      dupe_board = board.copy_board
      dupe_board.move(king_square, square.coord)
      return false unless check?(square.coord, dupe_board)
    end
    true
  end

  def no_available_moves?(king_square, board)
    board.node_array.each do |square|
      next if square.piece.nil? || square.piece.color != @color || square.piece.class.name.split('::').last == "King"

      original_coord = square.coord
      board.node_array.each do |potential_square|
        potential_coord = potential_square.coord
        next unless square.piece.valid_move?(original_coord, potential_coord, board)&&board.clear_path?(original_coord, potential_coord)

        dupe_board = board.copy_board
        dupe_board.move(original_coord, potential_coord)
        return false unless check?(king_square, dupe_board)
      end
    end
    true
  end

  def valid_horizontal?(initial, final)
    valid_horizontal_down?(initial, final) || valid_horizontal_up?(initial, final)
  end

  def valid_horizontal_up?(initial, final)
    initial[1] + 1 == final[1] && initial[0] == final[0]
  end

  def valid_horizontal_down?(initial, final)
    initial[1] - 1 == final[1] && initial[0] == final[0] # left one
  end

  def valid_vertical?(initial, final)
    valid_vertical_up?(initial, final) || valid_vertical_down?(initial, final)
  end

  def valid_vertical_down?(initial, final)
    initial[0] - 1 == final[0] && initial[1] == final[1] # down one
  end

  def valid_vertical_up?(initial, final)
    initial[0] + 1 == final[0] && initial[1] == final[1]
  end

  def valid_diaganol?(initial, final)
    valid_diagnol_up?(initial, final) || valid_diagnol_down?(initial, final)
  end

  def valid_diagnol_up?(initial, final)
    initial[0] + 1 == final[0] && (initial[1]+1 == final[1] || initial[1] - 1 == final[1])
  end

  def valid_diagnol_down?(initial, final)
    initial[0] - 1 == final[0] && (initial[1]+1 == final[1] || initial[1] - 1 == final[1])
  end

end