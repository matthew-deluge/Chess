
require_relative './piece'
# rook class, can move any number of spaces on either the rank or file it is currently on
class Rook < Piece

  def duplicate
    Rook.new(@color, @symbol)
  end
  
  def valid_move?(initial, final)
    return false if final[0] <= 0 || final[1] <= 0 || initial == final
    initial[0] == final[0] || initial[1] == final[1]
  end

  def generate_path(initial, final)
    # creates the array of moves to get from one square to another
    return false unless self.valid_move?(initial, final)
    
    if initial[0] == final[0]
      generate_rank_path(initial, final)
    else
      generate_file_path(initial, final)
    end
  end

  private
 
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
