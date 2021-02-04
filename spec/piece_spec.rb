# rspec file to test the pieces

# Rook test

require_relative '../lib/pieces/rook'

describe Rook do
  describe '#valid_move?' do
    subject(:rook) {described_class.new('white','R')}
    it 'returns true for a vertical move' do
      expect(rook.valid_move?([0,0], [0,1])).to be(true)
    end
    it 'returns true for a horizontal move' do
      expect(rook.valid_move?([0,0], [3,0])).to be(true)
    end
    it 'returns false for a non-horizontal or vertical move' do
      expect(rook.valid_move?([0,0],[3,4])).to be(false)
    end
  end
end
