# rspec file to test the pieces

# Rook test

require_relative '../lib/pieces/rook'

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
      expect(rook.valid_move?([0, 0], [0, 1])).to be(true)
    end
    it 'returns true for a horizontal move' do
      expect(rook.valid_move?([0, 0], [3, 0])).to be(true)
    end
    it 'returns false for a non-horizontal or vertical move' do
      expect(rook.valid_move?([0, 0], [3, 4])).to be(false)
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
  end
end
