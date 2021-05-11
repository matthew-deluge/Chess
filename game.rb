# game class, creates a new board and allows for the movement and capture of pieces

require_relative "./board.rb"

class game

  def intitialize
    board = Board.new
    