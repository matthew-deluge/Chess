
require_relative './piece'

# class for the king piece
Class King < Piece

  def valid_move?(initial, final)
    return false if final[0] <= 0 || final[1] <= 0

    if initial[0] - 1 == final[0] && initial[1] == final[1] # down one
      true
    elsif initial[0] + 1 == final[0] && initial[1] == final[1] # up one
      true
    elsif initial[1] - 1 == final[1] && initial[0] == final[0] # left one
      true
    elsif initial[1] + 1 == final[1] && inital[0] == final[0] #right one
      true
    elsif inital[0] + 1 == final[0] && (initial[1]+1 == final[1] || initial[1] - 1 == final[1]) # Diagnols up
      true
    elsif initial[0] - 1 == final[0] && (initial[1]+1 == final[1] || initial[1] - 1 == final[1]) # Diagnols down
      true
    else
      false
    end
  end

  def generate_path(initial, final)
    [intial, final]
  end

  private

  end
end
  