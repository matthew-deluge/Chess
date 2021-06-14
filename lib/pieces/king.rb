
require_relative './piece'

# class for the king piece
class King < Piece

  def valid_move?(initial, final)
    return false if final[0] <= 0 || final[1] <= 0

    valid_vertical?(initial,final)||valid_horizontal?(initial,final)||valid_diaganol?(initial, final)
  end

  def generate_path(initial, final)
    [intial, final]
  end


  private

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
