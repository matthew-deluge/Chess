# tests for the board class

require_relative '../lib/board'

describe Board do
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
end
