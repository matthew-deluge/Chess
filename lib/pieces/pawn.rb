require_relative './piece'

# pawn class, includes rules for en passant and diaganol capture

class Pawn < Piece

  def duplicate
    Pawn.new(@color, @symbol)
  end

  def valid_move?(initial, final, board = nil)
    if @color == 'white'
      white_valid_move?(initial, final, board)
    elsif @color == 'black'
      black_valid_move?(initial, final, board)
    end
  end

  def generate_path(initial, final)
    if final[1] == initial[1]+1
      [initial, final]
    elsif final[1] == initial[1]+2 && initial[0] == final[0]
      if @color == 'white'
        [initial, [final[0], final[0]+1], final]
      elsif @color == 'black'
        [initial, [final[0], final[0]-1], final]
      end
    end
  end

  private

  def white_valid_move?(initial, final, board)
    if final[1] == initial[1]+1
      if initial[0] == final[0]
        target_empty?(final, board)
      elsif initial[0] == final[0] +1 || initial[0] == final[0] - 1
        opponent_on_target?(final, board)
      end
    elsif final[1] == initial[1]+2 && initial[0] == final[0]
      !@moved && target_empty?(final, board)
    end
  end

  def black_valid_move? (initial, final, board)
    if final[1] == initial[1]-1
      if initial[0] == final[0]
        target_empty?(final, board)
      elsif initial[0] == final[0] +1 || initial[0] == final[0] - 1
        opponent_on_target?(final, board)
      end
    elsif final[1] == initial[1]-2 && initial[0] == final[0]
      !@moved && target_empty?(final, board)
    end
  end

  def opponent_on_target?(final, board)
    return false if board.find_square(final).piece.nil?

    piece = board.find_square(final).piece
    piece.color != @color
  end

  def target_empty?(final, board)
    board.find_square(final).piece.nil?
  end

end
