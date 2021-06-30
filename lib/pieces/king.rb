
require_relative './piece'

# class for the king piece
class King < Piece

  def duplicate
    new_piece = King.new(@color, @symbol)
    new_piece
  end

  def valid_move?(initial, final)
    return false if final[0] <= 0 || final[1] <= 0

    valid_vertical?(initial,final)||valid_horizontal?(initial,final)||valid_diaganol?(initial, final)
  end

  def generate_path(initial, final)
    [initial, final]
  end

  def check?(king_square, board)
    board.node_array.each do |square|
      next if square.piece.nil?

      unless square.piece.color == @color
        return true if square.piece.valid_move?(square.coord, king_square) && board.clear_path?(square.coord, king_square)
      end
    end
    false
  end

  def checkmate?(king_square, board)
  return false unless check?(king_square, board)

  no_available_moves?(king_square, board) && no_escape_path?(king_square, board)
  end

  private

  def no_escape_path?(king_square, board)
    board.node_array.each do |square|
      next unless valid_move?(king_square, square.coord) && board.clear_path?(king_square, square.coord)

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
        next unless square.piece.valid_move?(original_coord, potential_coord)&&board.clear_path?(original_coord, potential_coord)

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
