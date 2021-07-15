# frozen_string_literal: true

# Instructions Module for Chess Game
module Instructions

  def print_instructions
    puts "Welcome to Chess! \n \n"
    sleep(1)
    puts 'To move your piece, you need to enter two sets of coordinates. The first number will be the file, the second will be the rank.'
    puts 'For example, the white kings pawn starts on 5,2, and could be moved to 5,3 or 5,4 on its first turn'
    sleep(1)
    puts 'if you need to save and exit, just type save instead of selecting a piece. Good luck!'
    puts'Press C to go back to the menu, and press any other key to continue.'
    input = gets.chomp
    abort('thank you!') if input.downcase == 'c'
  end
end
