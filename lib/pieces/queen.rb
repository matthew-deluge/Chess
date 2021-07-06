require_relative './piece'
# queen class
class Queen < Piece

  def duplicate
    Queen.new(@color, @symbol)
  end
  
  def valid_move?(initial, final, _board = nil)
    return false unless valid_input?(initial, final)

    initial[0] == final[0] || initial[1] == final[1] || ((initial[0]-final[0]).abs - (initial[1]-final[1]).abs).zero?
  end

  def generate_path(initial, final)
    # creates the array of moves to get from one square to another
    return false unless valid_move?(initial, final)
    
    if initial[0] == final[0]
      generate_rank_path(initial, final)
    elsif initial[1] == final[1]
      generate_file_path(initial, final)
    elsif final[0]-initial[0] > 0  && final[1] - initial[1] > 0
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

  
  def generate_rank_path(initial, final)
    path = [initial]
    rank =  initial[1]
    until rank == final[1]
      if rank < final[1]
        rank += 1
      else
        rank -= 1
      end
      path.push([initial[0], rank])
    end
    path
  end

  def generate_file_path(initial, final)
    path = [initial]
    file = initial[0] 
    until file == final[0]
      if file < final[0] 
        file += 1
      else
        file -= 1
      end
      path.push([file, initial[1]])
    end
    path
  end

end