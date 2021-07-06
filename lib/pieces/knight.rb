require_relative './piece'

# knight class, can move two spaces in any direction, followed by one space in a parallel direction
class Knight < Piece

  def duplicate
    Knight.new(@color, @symbol)
  end
  
  def valid_move?(initial, final)
    return false if final[0] <= 0 || final[1] <= 0 || final[0] >= 9 || final[1] >=9 || initial == final
    first_diff = initial[0] - final[0]
    second_diff = initial[1] - final[1]
    if first_diff.abs == 2 && second_diff.abs == 1 || first_diff.abs == 1 && second_diff.abs == 2
      true
    else
      false
    end
  end

  def generate_path(initial, final)
    [initial, final]
  end
  
end
