require_relative './piece'

class Bishop < Piece

  def duplicate
    Bishop.new(@color, @symbol)
  end

  def valid_move?(initial, final)
    return false if final[0] <= 0 || final[1] <= 0 || final[0] >=9 || final[1] >= 9

    return false if final[0] == initial[0] && final[1] == initial[1]
    
    (initial[0]-final[0]).abs - (initial[1]-final[1]).abs == 0
  end

  def generate_path(initial, final)
    # creates the array of moves to get from one square to another
    return unless valid_move?(initial, final)

    if final[0]-initial[0] > 0  && final[1] - initial[1] > 0
      generate_up_left_path(initial, final)
    elsif final[0]-initial[0] < 0  && final[1] - initial[1] < 0
      generate_down_right_path(initial, final)
    elsif final[0]-initial[0] < 0  && final[1] - initial[1] > 0
      generate_up_right_path(initial, final)
    elsif final[0]-initial[0] > 0  && final[1] - initial[1] < 0
      generate_down_left_path(initial, final)
    end
  end

  private

  def  generate_up_left_path(initial, final)
    path = [initial]
    x_coord = initial[0]
    y_coord = initial[1]
    until x_coord == final[0]&& y_coord == final[1]
      x_coord += 1
      y_coord += 1
      path.push([x_coord, y_coord])
    end
    path
  end

  def generate_down_right_path (initial, final)
    path = [initial]
    x_coord = initial[0]
    y_coord = initial[1]
    until x_coord == final[0]&& y_coord == final[1]
      x_coord -= 1
      y_coord -= 1
      path.push([x_coord, y_coord])
    end
    path
  end

  def generate_up_right_path(initial, final)
    path = [initial]
    x_coord = initial[0]
    y_coord = initial[1]
    until x_coord == final[0] && y_coord == final[1]
      x_coord -= 1
      y_coord += 1
      path.push([x_coord, y_coord])
    end
    path
  end

  def generate_down_left_path (initial, final)
    path = [initial]
    x_coord = initial[0]
    y_coord = initial[1]
    until x_coord == final[0]&& y_coord == final[1]
      x_coord += 1
      y_coord -= 1
      path.push([x_coord, y_coord])
    end
    path
  end
 

end
