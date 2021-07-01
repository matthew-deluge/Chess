# game class, creates a new board and allows for the movement and capture of pieces

require_relative "./lib/board.rb"


class String
  def is_integer?
    self.to_i.to_s == self
  end
end


class Game

  attr_accessor :board, :white_captured, :black_captured

  def initialize
    @board = Board.new
    @board.set_pieces
    @white_captured = []
    @black_captured = []
  end

  def player_move(player_color, board = @board)
    board.print_board(board)
    player_piece = get_player_piece(player_color)
    player_move = get_player_move(player_color, player_piece, board)
    board.move(player_piece, player_move)
    board.print_board(board)
  end

  def get_player_piece(player_color)
    puts "#{player_color}, please enter the coordinates of the piece you want to move:"
    player_input = gets.chomp
    until valid_response?(player_input)
      puts 'please enter the coordinates as two numbers seperated by a comma'
      player_input = gets.chomp
    end
    while board.find_square(convert_to_coordinates(player_input)).piece.nil? || @board.find_square(convert_to_coordinates(player_input)).piece.color != player_color
      puts 'please select a piece of your color'
      player_input = get_player_piece(player_color)
    end
    convert_to_coordinates(player_input)
  end

  def get_player_move(player_color, player_piece, board=@board)
    puts 'please enter the coordinates of where you want to move your piece'
    player_input = gets.chomp
    until valid_response?(player_input)
      puts 'please enter the coordinates as two numbers seperated by a comma'
      player_input = gets.chomp
    end
    puts "the possible move is #{player_piece} to #{convert_to_coordinates(player_input)}"
    until board.clear_path?(player_piece, convert_to_coordinates(player_input))
      puts 'please enter a valid destination'
      player_input = get_player_move(player_color, player_piece, board)
    end
    convert_to_coordinates(player_input)
  end


  def convert_to_coordinates(input)
    split_input = input.strip.split(',')
    split_input.each_with_index { |number, index| split_input[index] = number.to_i }
    split_input
  end

  def valid_response?(input)
    return false unless input.include?(',')

    split_input = input.strip.split(',')
    if split_input.length == 2 && split_input[0].is_integer? && split_input[1].is_integer?
      return split_input[0].to_i >= 1 && split_input[0].to_i <= 8 && split_input[1].to_i >= 1 && split_input[1].to_i <= 8
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

  def play
    #print instructions
    #@board.print_board(@board)
    until checkmate?
      player_move('white')
      player_move('black')
    end
    #endgame
  end
end
  
game = Game.new
game.play

    