# tests for the board class

require_relative '../lib/board'

describe Board do

  describe '#add_piece' do
    subject(:piece_board) { described_class.new }
    context 'when passed a piece' do
      it 'puts that piece on the correct square' do
        test_piece = Rook.new('white','r')
        piece_board.add_piece([8,8], test_piece)
        expect(piece_board.find_square([8,8]).piece).to be(test_piece)
      end
      it 'leaves other squares alone' do
        test_piece = Rook.new('white','r')
        piece_board.add_piece([8,8], test_piece)
        expect(piece_board.find_square([8,7]).piece).to be(nil)
      end
    end
  end

  describe '#clear_path?' do
    subject(:path_board) {described_class.new}
    context '#when passed a piece with a clear path' do
      it 'returns true' do
        test_rook = Rook.new('white', 'r')
        path_clarity = path_board.clear_path?(test_rook, [1, 1], [1,4])
        expect(path_clarity).to be(true)
      end
    end
    context 'when passed a piece without a clear path' do
      it 'returns false' do
        path_board.add_piece([1, 3], Rook.new('white','r'))
        test_rook = Rook.new('white', 'r')
        path_clarity = path_board.clear_path?(test_rook, [1, 1], [1,4])
        expect(path_clarity).to be(false)
      end
    end
  end

  describe '#set_pieces' do
    subject(:filled_board) {described_class.new}
    context 'when calledd' do
      it 'puts correct pieces in place' do
        filled_board.set_pieces
        expect(filled_board.find_square([1,1]).piece.symbol).to eq('♜')
      end
    end
  end
end
