
require_relative './piece'

# class for the king piece
class King < Piece

  def valid_move?(initial, final)
    return false if final[0] <= 0 || final[1] <= 0

    valid_vertical?(initial,final)||valid_horizontal?(initial,final)||valid_diaganol?(initial, final)
  end

  def generate_path(_initial, final)
    [_intial, final]
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
    return false unless king_square.piece.check?

    no_available_blockers?(king_square, board) || no_escape_path?(king_square, board)


    

  private

  def no_escape_path?(king_square, board)
    board.node_array.each do |square|
      if valid_move?(king_square, square.coord)
        board_copy = board
        board_copy.move(king_square, square.coord)
        return false unless check?(king_square, board_copy)
      end
    end
    true
  end
  
  def no_available_blockers?(king_square, board)
    board.node_array.each do |square|
      next if square.piece.nil?||square.piece.color != @color

      original_coord = square.coord
      board.node_array.each do |potential_square|
        potential_coord = potential_square.coord
        board_copy = board
        if board.clear_path?(original_coord, potential_coord)
          board.move(original_coord, potential_coord)
          if check?(king_square, board_copy)
            next
          else
            false
          end
        end
      end
    end
    true
  end

        potential_square.coord

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
