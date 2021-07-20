# rspec file to test the Game class

require_relative '../lib/game.rb'

describe Game do
  describe '#valid_response?' do
    subject(:valid_game) {described_class.new}
    it 'returns false when passed a word' do
      validity = valid_game.valid_response?('taco')
      expect(validity).to be(false)
    end
    it 'returns false when there is no comma' do
      validity = valid_game.valid_response?('1 2')
      expect(validity).to be(false)
    end
    it 'returns false when the numbers are too high' do
      validity = valid_game.valid_response?('1, 16')
      expect(validity).to be(false)
    end
    it 'returns false when the numbers are too low' do
      validity = valid_game.valid_response?('0, 8')
      expect(validity).to be(false)
    end
    it 'returns true when passed a valid coordinate' do
      validity = valid_game.valid_response?('1, 2')
      expect(validity).to be(false)
    end
  end

  describe '#draw?' do
    subject(:draw_game) {described_class.new}
    it 'returns true when there are only two kings remaining' do
      board = Board.new
      board.add_piece( [1,1], King.new('white', 'k') )
      board.add_piece( [8,8], King.new('black', 'k') )
      result = draw_game.draw?(board)
      expect(result).to be(true)
    end

    it 'returns true when there is only two kings and a bishop' do
      board = Board.new
      board.add_piece( [1,1], King.new( 'white', 'k' ) )
      board.add_piece( [8,8], King.new( 'black', 'k' ) )
      board.add_piece( [1,2], Bishop.new( 'black', 'b') )
      result = draw_game.draw?(board)
      expect(result).to be(true)
    end

    it 'returns true when there is only two kings and a knight' do
      board = Board.new
      board.add_piece( [1,1], King.new( 'white', 'k' ) )
      board.add_piece( [8,8], King.new( 'black', 'k' ) )
      board.add_piece( [1,2], Knight.new( 'black', 'b') )
      result = draw_game.draw?(board)
      expect(result).to be(true)
    end

    it 'returns true when there is only two kings and matching bishops' do
      board = Board.new
      board.add_piece( [1,1], King.new( 'white', 'k' ) )
      board.add_piece( [8,8], King.new( 'black', 'k' ) )
      board.add_piece( [1,2], Bishop.new( 'black', 'b') )
      board.add_piece( [3,4], Bishop.new( 'white', 'b') )
      result = draw_game.draw?(board)
      expect(result).to be(true)
    end

    it 'returns false when there are two kings and a queen' do
      board = Board.new
      board.add_piece( [1,1], King.new( 'white', 'k' ) )
      board.add_piece( [8,8], King.new( 'black', 'k' ) )
      board.add_piece( [1,2], Queen.new( 'white', 'q') )
      result = draw_game.draw?(board)
      expect(result).to be(false)
    end

    it 'returns true when the king has no possible moves' do
      board = Board.new
      board.add_piece( [1,8], King.new( 'white', 'k' ) )
      board.add_piece( [8,8], King.new( 'black', 'k' ) )
      board.add_piece( [3,7], Queen.new( 'black', 'q') )
      result = draw_game.draw?(board)
      expect(result).to be(true)
    end
  end
end


  
  