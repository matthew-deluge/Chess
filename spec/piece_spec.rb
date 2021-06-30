# rspec file to test the pieces

require_relative '../lib/board'
require_relative '../lib/pieces/rook'
require_relative '../lib/pieces/king'

describe Rook do

  describe '#color' do
    subject(:rook) {described_class.new('white' , 'R')}
    it 'returns passed color' do
      expect(rook.color).to eq('white')
    end
  end

  describe '#symbol' do
    subject(:rook) {described_class.new('white' , 'R')}
    it 'returns passed color' do
      expect(rook.symbol).to eq('R')
    end
  end

  describe '#valid_move?' do
    subject(:rook) {described_class.new('white','R')}
    it 'returns true for a vertical move' do
      expect(rook.valid_move?([1, 1], [1, 2])).to be(true)
    end
    it 'returns true for a horizontal move' do
      expect(rook.valid_move?([1, 1], [4, 1])).to be(true)
    end
    it 'returns false for a non-horizontal or vertical move' do
      expect(rook.valid_move?([1, 1], [3, 4])).to be(false)
    end
  end

  describe '#generate_path' do
    subject(:rook) {described_class.new('white','R')}
    context 'when passed a one square move' do
      it 'returns an array with the initial and final move' do
        path = rook.generate_path([1,1],[1,2])
        expect(path).to eq([[1,1],[1,2]])
      end
    end
    context 'when passed a longer move' do
      it 'returns every square in that move' do
        path = rook.generate_path([1,1],[8,1])
        expect(path).to eq([[1,1], [2,1], [3,1], [4,1], [5,1], [6,1], [7,1], [8,1]])
      end
    end
    context 'when passed a non-move' do
      it 'returns false' do
        path = rook.generate_path([2,2],[3,3])
        expect(path).to eq(false)
      end
    end
    context 'when passed a move down or left' do
      it 'returns a valid path' do
        path = rook.generate_path([3,1],[1,1])
        expect(path).to eq([[3,1],[2,1],[1,1]])
      end
    end
  end
end

describe King do
  describe 'valid_move?' do
    subject(:king) {described_class.new('white', 'K')}
    it 'returns true for a vertical move up' do
      expect(king.valid_move?([1,1], [1,2])).to be(true)
    end
    it 'returns true for a vertical move down' do
      expect(king.valid_move?([2,2], [2,1])).to be(true)
    end
    it 'returns true for a horizontal move right' do
      expect(king.valid_move?([1,1], [2,1])).to be(true)
    end
    it 'returns true for a horizontal move left' do
      expect(king.valid_move?([3,3], [2,3])).to be(true)
    end
    it 'returns true for an upward diagnol move' do
      expect(king.valid_move?([1,1],[2,2])).to be(true)
    end
    it 'returns true for a downward diagnol move' do
      expect(king.valid_move?([3,3], [2,4])).to be(true)
    end
    it 'returns false for a two space move' do
      expect(king.valid_move?([1,1], [1,5])).to be(false)
    end
  end

  describe 'check?' do
    subject(:king) {described_class.new('white', 'K')}

    it 'returns true if square is threatened' do
      board = Board.new
      board.add_piece([1,1], Rook.new('black', 'r'))
      board.add_piece([1,2], king)
      expect(king.check?([1,2], board)).to be(true)
    end

    it 'returns false if a safe square' do
      board = Board.new
      board.add_piece([1,1], Rook.new('black', 'r'))
      board.add_piece([3,3], king)
      expect(king.check?([3,3], board)).to be(false)
    end

    it 'returns false if threatned by same color piece' do
      board = Board.new
      board.add_piece([3,3], Rook.new('white', 'r'))
      board.add_piece([3,4], king)
      expect(king.check?([3,4], board)).to be(false)
    end
  end

  describe 'checkmate?' do
    subject(:checkmate_king) {described_class.new('white','K')}
    
    it 'returns true if king is checkmated' do
      board = Board.new
      board.add_piece([4,4], Rook.new('black','r'))
      board.add_piece([5,4], Rook.new('black','r'))
      board.add_piece([6,4], Rook.new('black','r'))
      board.add_piece([5,1], checkmate_king)
      expect(checkmate_king.checkmate?([5,1], board)).to be(true)
    end

    it 'returns false if king can flee' do
      board = Board.new
      board.add_piece([4,4], Rook.new('black','r'))
      board.add_piece([4,1], checkmate_king)
      expect(checkmate_king.checkmate?([4,1], board)).to be(false)
    end

    it 'returns false if there is a blocker' do
      board = Board.new
      board.add_piece([4,4], Rook.new('black','r'))
      board.add_piece([5,4], Rook.new('black','r'))
      board.add_piece([6,4], Rook.new('black','r'))
      board.add_piece([6,2], Rook.new('white','r'))
      board.add_piece([5,1], checkmate_king)
      expect(checkmate_king.checkmate?([5,1], board)).to be(false)
    end

    it 'returns false if the threat can be removed' do
      board = Board.new
      board.add_piece([4,4], Rook.new('black','r'))
      board.add_piece([5,4], Rook.new('black','r'))
      board.add_piece([6,4], Rook.new('black','r'))
      board.add_piece([5,5], Rook.new('white','r'))
      board.add_piece([5,1], checkmate_king)
      expect(checkmate_king.checkmate?([5,1], board)).to be(false)
    end

  end
end



