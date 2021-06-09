# game class, creates a new board and allows for the movement and capture of pieces

require_relative "./board.rb"

class Game

  def intitialize
    board = Board.new
    board.set_pieces
    @white_captured = []
    @black_captured = []
  end

  def player_move(player_color)
    puts "#{player_color}, please enter the coordinates of the piece you want to move:"
    origin_coord = gets.chomp
    while board.find_square(origin_coord).piece.nil? || board.find_square(origin_coord.piece.color != player_color)
      puts "please select a piece of your color"
      origin_coord = gets.chomp
    end
    puts "please enter the coordinates of where you want to move your piece"
    target_coord = gets.chomp
    until board.clear_path?(origin_coord, target_coord)
      puts "please enter a valid destination"
      target_coord = gets.chomp
    end
  end

  def play
    print instructions
    print board
    until checkmate?('black') || checkmate?('white')
      player_move('white')
      player_move('black')
  


    