# frozen_string_literal: true"

require_relative './game'
require_relative './computer_game'

# Menu that allows player to choose the type of game they want to play, or load a saved game
class Menu

  WELCOME_MESSAGE = 'Welcome to Chess, a program by Matthew Deluge! Press any key to begin.'.freeze
  MENU = "Enter the number for the game you would like to play:\n
  1) Chess against a friend\n
  2) Load a saved game against a Friend\n
  3) Chess against a computer\n
  4) Load a saved game against a computer\n
  5) Exit program".freeze

  def clear_screen
    print "\e[2J\e[f"
  end

  def print_welcome
    clear_screen
    puts WELCOME_MESSAGE
    gets.chomp
  end

  def run
    print_welcome
    loop do
      clear_screen
      puts MENU
      input = gets.chomp
      case input
      when '1'
        play_game
      when '2'
        play_saved_game
      when '3'
        play_computer_game
      when '4'
        play_saved_computer_game
      when '5'
        Exit
      end
    end
  end

  def play_game
    game = Game.new
    game.play
  end

  def play_saved_game
    game = Game.new
    game.load_file
    game.play
  end

  def play_computer_game
    game = ComputerGame.new
    game.play
  end

  def play_saved_computer_game
    game = ComputerGame.new
    game.load_file
  end

end
