require_relative './piece'

# pawn class, includes rules for diagonal capture and double move
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
    if (final[1] - initial[1]).abs == 1
      [initial, final]
    elsif (final[1]-initial[1]).abs == 2 && initial[0] == final[0] # returns path if pawn moves two spaces
      if @color == 'white'
        [initial, [final[0], final[1]-1], final]
      elsif @color == 'black'
        [initial, [final[0], final[1]+1], final]
      end
    end
  end

  def en_passant?(initial, final, board)
    if @color == 'white'
      white_en_passant?(initial, final, board)
    elsif @color == 'black'
      black_en_passant?(initial, final, board)
    end
  end

  private

  def white_valid_move?(initial, final, board)
    if final[1] == initial[1]+1
      if initial[0] == final[0]
        target_empty?(final, board)
      elsif initial[0] == final[0] +1 || initial[0] == final[0] - 1
        opponent_on_target?(final, board) || white_en_passant?(initial, final, board)
      end
    elsif final[1] == initial[1]+2 && initial[0] == final[0]
      !@moved && target_empty?(final, board)
    end
  end

  def white_en_passant?(initial, final, board)
    return false unless initial[1] == 5

    last_move = board.move_array.last
    target_square = board.find_square(last_move.last)
    target = target_square.piece

    if target.is_a?(Pawn) && last_move[1][1]+1 == final[1] && last_move[1][0] == final[0]
      board.captured_pieces.push(target)
      board.find_square(last_move[1]).piece = nil
      true
    else
      false
    end
  end


  def black_en_passant?(initial, final, board)
    return false unless initial[1] == 4

    last_move = board.move_array.last
    target_square = board.find_square(last_move[1])
    target = target_square.piece
    if target.is_a?(Pawn) && last_move[1][1] - 1 == final[1] && last_move[1][0] == final[0]
      board.captured_pieces.push(target)
      board.find_square(last_move[1]).piece = nil
      true
    else
      false
    end
  end

  def black_valid_move? (initial, final, board)
    if final[1] == initial[1]-1
      if initial[0] == final[0]
        target_empty?(final, board)
      elsif initial[0] == final[0] +1 || initial[0] == final[0] - 1
        opponent_on_target?(final, board) || black_en_passant?(initial, final, board)
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
