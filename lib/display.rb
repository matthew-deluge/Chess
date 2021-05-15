# frozen_string_literal: true

# Display Module for Chess Game
module Display

  def print_board(board)
    board.node_array.reverse.each do |square|
      if square.coord[1] == 8
        puts "\n"
      end
      if square.piece.nil?
        if (square.coord[0]+square.coord[1]).even?
          print "B".light_blue
        else
          print "W"
        end
      else 
        print square.piece.symbol
      end
    end
  end
end
        

  # allows for colored strings: https://stackoverflow.com/questions/1489183/colorized-ruby-output-to-the-terminal
class String
  # colorization
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end

  def red
    colorize(31)
  end

  def green
    colorize(32)
  end

  def yellow
    colorize(33)
  end

  def blue
    colorize(34)
  end

  def pink
    colorize(35)
  end

  def light_blue
    colorize(36)
  end
end
