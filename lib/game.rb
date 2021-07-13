# game class, creates a new board and allows for the movement and capture of pieces

require_relative "./board.rb"


class String
  def is_integer?
    self.to_i.to_s == self
  end
end

# class with the game loop and win conditions
class Game
  require 'yaml'
  attr_accessor :board

  def initialize
    @board = Board.new
    @board.set_pieces
    @current_player = 'white'
  end

  def clear_screen
    print "\e[2J\e[f"
  end

  def player_move(board = @board)
    clear_screen
    board.print_board(board)
    player_move = get_player_move(board)
    board.move(player_move[0], player_move[1])
    @current_player == 'white' ? @current_player = 'black' : @current_player = 'white'
  end

  def get_player_piece
    puts "#{@current_player}, please enter the coordinates of the piece you want to move:"
    player_input = gets.chomp
    if player_input.downcase == 'save'
      save_file
    end
    until valid_response?(player_input)
      puts 'please enter the coordinates as two numbers seperated by a comma'
      player_input = get_player_piece
    end
    while board.find_square(convert_to_coordinates(player_input)).piece.nil? || @board.find_square(convert_to_coordinates(player_input)).piece.color != @current_player
      puts 'please select a piece of your color'
      player_input = get_player_piece
    end
    convert_to_coordinates(player_input)
  end

  def get_player_move(board=@board)
    player_piece = get_player_piece
    puts 'Please enter the coordinates of where you want to move your piece'
    player_input = [player_piece, gets.chomp]
    until valid_response?(player_input[1])
      puts 'Please enter the coordinates as two numbers seperated by a comma'
      player_input = get_player_move(board)
    end
    until board.clear_path?(player_input[0], convert_to_coordinates(player_input[1]))
      puts 'Invalid destination'
      player_input = get_player_move(board)
    end
    while move_in_check?(@current_player, player_input[0], convert_to_coordinates(player_input[1]), board)
      puts 'Illegal move: king in check'
      player_input = get_player_move(board)
    end
    [player_input[0], convert_to_coordinates(player_input[1])]
  end

  def convert_to_coordinates(input)
    return input if input.is_a?(Array)

    split_input = input.strip.split(',')
    split_input.each_with_index { |number, index| split_input[index] = number.to_i }
    split_input
  end

  def valid_response?(input)
    return false unless input.include?(',')

    split_input = input.strip.split(',')
    p input
    if split_input.length == 2 && split_input[0].is_integer? && split_input[1].is_integer?
      return split_input[0].to_i >= 1 && split_input[0].to_i <= 8 && split_input[1].to_i >= 1 && split_input[1].to_i <= 8
    end
    false
  end

  def move_in_check?(player_color, player_piece, player_move, board=@board)
    board_copy = board.copy_board
    board_copy.move(player_piece, player_move)
    board_copy.node_array.each do |square|
      if !square.piece.nil? && square.piece.is_a?(King)
          return true if square.piece.check?(square.coord, board_copy) && square.piece.color == player_color
      end
    end
    false
  end

  def checkmate?
    @board.node_array.each do |square|
      unless square.piece.nil? 
        if square.piece.is_a?(King)
          return true if square.piece.checkmate?(square.coord, @board)
        end
      end
    end
    false
  end

  def black_turn?
    board.find_square(board.move_array[-1][1]).piece.color == 'white'
  end

  def save_file
    save_object = YAML::dump(@board)
    File.open('save_data.yml', 'w') { |file| file.write(save_object) }
    puts 'File saved, see you again soon!'
    exit
  end

  def load_file
    file = File.read('save_data.yml')
    @board = YAML::load(file)
    puts "Welcome back!"
    @board.print_board(@board)
  end

  def play
    #print instructions
    #load_file
    #@current_player = black if black_turn?
    until checkmate?
      player_move
    end
    #endgame
  end
end
  
game = Game.new
game.play

    