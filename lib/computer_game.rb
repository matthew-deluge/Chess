# computer_game class, allows play against a computer

require_relative './game.rb'

class ComputerGame < Game

  def initialize
    super
    @computer_color = prompt_player_color
  end


  def computer_move
    return if checkmate?

    move_set = collect_potential_moves
    move = move_set.sample
    move = move_set.sample while move_in_check?(@computer_color, move[0], move[1])
    board.move(move[0], move[1])
    @current_player == 'white' ? @current_player = 'black' : @current_player = 'white'
  end

  def collect_potential_moves
    square_array = board.node_array.select { |square| !square.piece.nil? && square.piece.color == @computer_color}
    move_list = []
    square_array.each do |square|
      board.node_array.each do |target| 
        move_list.push([square.coord, target.coord]) if @board.clear_path?(square.coord, target.coord)
      end
    end
    move_list
  end

  def prompt_player_color
    options = ['1','2']
    puts "What color would you like to play as? (enter the number)\n\n1)White\n2)Black"
    input = gets.chomp
    unless options.include?(input)
      puts 'Please enter the number of the color you would like to play as:\n\n1) White\n2)Black'
      input = gets.chomp
    end
    if input == '1'
      'black'
    else
      'white'
    end
  end

  def play
    print_instructions
    if @computer_color == @current_player
      until checkmate?
        computer_move
        player_move
      end
    elsif @computer_color != @current_player
      until checkmate?
        player_move
        computer_move
      end
    end
    puts "Congrats #{@current_player}, you have checkmated your opponent, nice work!"
  end
end
