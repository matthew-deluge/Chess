# rspec file to test the pieces

require_relative '../lib/board'
require_relative '../lib/pieces/rook'
require_relative '../lib/pieces/king'
require_relative '../lib/pieces/bishop'
require_relative '../lib/pieces/queen'
require_relative '../lib/pieces/knight'
require_relative '../lib/pieces/pawn'

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

  describe '#castle?' do
    context 'When called on a white piece' do
      subject(:castle_king) { described_class.new('white', 'K') }

      it 'returns true if castling is an option on king side' do
        board = Board.new
        board.add_piece( [8,1], Rook.new('white', 'r') )
        board.add_piece( [5,1], castle_king)
        result = castle_king.castle?([5,1], [7,1], board)
        expect(result).to be(true)
      end

      it 'returns true if castling is an option on left side' do
        board = Board.new
        board.add_piece( [1,1], Rook.new('white', 'r') )
        board.add_piece( [5,1], castle_king)
        result = castle_king.castle?([5,1], [3,1], board)
        expect(result).to be(true)
      end

      it 'returns false if there is a piece blocking the way' do
        board = Board.new
        board.add_piece([1,1], Rook.new('white', 'r') )
        board.add_piece([5,1], castle_king)
        board.add_piece([3,1], Knight.new('white', 'n'))
        result = castle_king.castle?([5,1], [3,1], board)
        expect(result).to be(false)
      end

      it 'returns false if the Rook has moved' do
        board = Board.new
        test_rook = Rook.new('white', 'r')
        test_rook.moved = true
        board.add_piece( [1,1], test_rook )
        board.add_piece( [5,1], castle_king)
        result = castle_king.castle?([5,1], [3,1], board)
        expect(result).to be(false)
      end

      it 'returns false if king would be in check' do
        board = Board.new
        board.add_piece( [8,1], Rook.new('white', 'r') )
        board.add_piece( [5,1], castle_king)
        board.add_piece([6,6], Rook.new('black', 'r') )
        result = castle_king.castle?([5,1], [7,1], board)
        expect(result).to be(false)
      end

      it 'returns false if the king has moved' do
        board = Board.new
        castle_king.moved = true
        board.add_piece( [8,1], Rook.new('white', 'r') )
        board.add_piece( [5,1], castle_king)
        result = castle_king.castle?([5,1], [7,1], board)
        expect(result).to be(false)
      end
    end
  end

  describe 'castle_move' do
    subject(:castle_move_king) { described_class.new('white', 'K') }
    it 'moves king when castled kingside' do
      board = Board.new
      board.add_piece( [8,1], Rook.new('white', 'r') )
      board.add_piece( [5,1], castle_move_king)
      castle_move_king.castle_move([5,1], [7,1], board)
      king_check = board.find_square([7,1]).piece.is_a?(King)
      expect(king_check).to be(true)
    end

    it 'moves rook when castled kingside' do
      board = Board.new
      board.add_piece( [8,1], Rook.new('white', 'r') )
      board.add_piece( [5,1], castle_move_king)
      castle_move_king.castle_move([5,1], [7,1], board)
      rook_check = board.find_square([6,1]).piece.is_a?(Rook)
      expect(rook_check).to be(true)
    end

    it 'moves king when castled queenside' do
      board = Board.new
      board.add_piece( [1,1], Rook.new('white', 'r') )
      board.add_piece( [5,1], castle_move_king)
      castle_move_king.castle_move([5,1], [3,1], board)
      king_check = board.find_square([3,1]).piece.is_a?(King)
      expect(king_check).to be(true)
    end

    it 'moves rook when castled queenside' do
      board = Board.new
      board.add_piece( [1,1], Rook.new('white', 'r') )
      board.add_piece( [5,1], castle_move_king)
      castle_move_king.castle_move([5,1], [3,1], board)
      rook_check = board.find_square([4,1]).piece.is_a?(Rook)
      expect(rook_check).to be(true)
    end
  end

    
end

describe Bishop do 
  describe "#valid_move?" do
    subject(:move_bishop) { described_class.new('white', 'b') }

    it "returns true for an up left move" do
      result = move_bishop.valid_move?([2,2],[3,3])
      expect(result).to be(true)
    end

    it "returns true for an up right move" do
      result = move_bishop.valid_move?([2,2],[1,3])
      expect(result).to be(true)
    end

    it "returns true for a down right move" do
      result = move_bishop.valid_move?([5,5],[1,1])
      expect(result).to be(true)
    end

    it "returns true for a down left move" do
      result = move_bishop.valid_move?([5,5],[3,7])
      expect(result).to be(true)
    end

    it 'returns false for a non-move' do
      result = move_bishop.valid_move?([2,2],[4,7])
      expect(result).to be(false)
    end
  end

  describe "#generate_path" do
    subject(:path_bishop) { described_class.new('white', 'b') }

    it 'correctly plots up left path' do
      path = path_bishop.generate_path([1,1], [4,4])
      expect(path).to eq([[1,1], [2,2], [3,3], [4,4]])
    end

    it 'correctly plots down right path' do
      path = path_bishop.generate_path([5,6], [2,3])
      expect(path).to eq([[5,6], [4,5], [3,4], [2,3]])
    end

    it 'correctly plots up right path' do
      path = path_bishop.generate_path([4,5], [1,8])
      expect(path).to eq([[4,5], [3,6], [2,7], [1,8]])
    end

    it 'correctly plots down left path' do
      path = path_bishop.generate_path([4,5], [6,3])
      expect(path).to eq([[4,5], [5,4], [6,3]])
    end
  end
end

describe Queen do

  describe '#valid_move?' do
    subject(:move_queen) {described_class.new('white','Q')}
    it 'returns true for a vertical move' do
      expect(move_queen.valid_move?([1, 1], [1, 2])).to be(true)
    end
    it 'returns true for a horizontal move' do
      expect(move_queen.valid_move?([1, 1], [4, 1])).to be(true)
    end
    it "returns true for an up left move" do
      result = move_queen.valid_move?([2,2],[3,3])
      expect(result).to be(true)
    end

    it "returns true for an up right move" do
      result = move_queen.valid_move?([2,2],[1,3])
      expect(result).to be(true)
    end

    it "returns true for a down right move" do
      result = move_queen.valid_move?([5,5],[1,1])
      expect(result).to be(true)
    end

    it "returns true for a down left move" do
      result = move_queen.valid_move?([5,5],[3,7])
      expect(result).to be(true)
    end

    it 'returns false for a non-horizontal, vertical, or diaganol move' do
      expect(move_queen.valid_move?([1, 1], [3, 4])).to be(false)
    end

    it 'returns false for a non-move' do
      result = move_queen.valid_move?([2,2],[4,7])
      expect(result).to be(false)
    end
  end

  describe "#generate_path" do
    subject(:path_queen) { described_class.new('black', 'Q') }

    context 'when passed a one square move' do
      it 'returns an array with the initial and final move' do
        path = path_queen.generate_path([1,1],[1,2])
        expect(path).to eq([[1,1],[1,2]])
      end
    end

    context 'when passed a longer move' do
      it 'returns every square in that move' do
        path = path_queen.generate_path([1,1],[8,1])
        expect(path).to eq([[1,1], [2,1], [3,1], [4,1], [5,1], [6,1], [7,1], [8,1]])
      end
    end

    context 'when passed a non-move' do
      it 'returns false' do
        path = path_queen.generate_path([2,2],[3,7])
        expect(path).to eq(false)
      end
    end

    context 'when passed a move down or left' do
      it 'returns a valid path' do
        path = path_queen.generate_path([3,1],[1,1])
        expect(path).to eq([[3,1],[2,1],[1,1]])
      end
    end

    it 'correctly plots up left path' do
      path = path_queen.generate_path([1,1], [4,4])
      expect(path).to eq([[1,1], [2,2], [3,3], [4,4]])
    end

    it 'correctly plots down right path' do
      path = path_queen.generate_path([5,6], [2,3])
      expect(path).to eq([[5,6], [4,5], [3,4], [2,3]])
    end

    it 'correctly plots up right path' do
      path = path_queen.generate_path([4,5], [1,8])
      expect(path).to eq([[4,5], [3,6], [2,7], [1,8]])
    end

    it 'correctly plots down left path' do
      path = path_queen.generate_path([4,5], [6,3])
      expect(path).to eq([[4,5], [5,4], [6,3]])
    end
  end
end

describe Knight do
  describe '#valid_move?' do
    subject(:move_knight) { described_class.new('black','N') }

    it 'returns true for a valid knight move' do
      result = move_knight.valid_move?( [3,3], [4,5] )
      expect(result).to be(true)
    end

    it 'returns false for an invalid knight move' do
      result = move_knight.valid_move?( [1,1], [6,7] )
      expect(result).to be(false)
    end
  end
end

describe Pawn do

  describe 'valid_move?' do
    context 'when a white piece is moved' do
      subject(:move_pawn) { described_class.new('white', 'P') }
      it 'returns true if an unmoved piece if moved two clear squares forward' do
        board = Board.new
        board.add_piece([1,1], move_pawn)
        result = move_pawn.valid_move?([1,1], [1,3], board)
        expect(result).to be(true)
      end

      it 'returns true if an unmoved piece is moved one space' do
        board = Board.new
        board.add_piece([1,1], move_pawn)
        result = move_pawn.valid_move?([1,1], [1,2], board)
        expect(result).to be(true)
      end

      it 'returns false if a moved pawn tries to move two spaces' do
        board = Board.new
        board.add_piece([1,1], move_pawn)
        move_pawn.moved = true
        result = move_pawn.valid_move?([1,1], [1,3], board)
        expect(result).to be(false)
      end

      it 'returns true if a moved pawn tries to move one space' do
        board = Board.new
        board.add_piece([1,1], move_pawn)
        move_pawn.moved = true
        result = move_pawn.valid_move?([1,1], [1,2], board)
        expect(result).to be(true)
      end

      it 'returns false when piece is on move square' do
        board = Board.new
        board.add_piece([1,1], move_pawn)
        board.add_piece([1,2], Rook.new('white', 'R'))
        result = move_pawn.valid_move?([1,1], [1,2], board)
        expect(result).to be(false)
      end

      it 'returns true when diagonally capturing' do
        board = Board.new
        board.add_piece([1,1], move_pawn)
        board.add_piece([2,2], Rook.new('black', 'R'))
        result = move_pawn.valid_move?([1,1], [2,2], board)
        expect(result).to be(true)
      end

      it 'returns false when diagonally moving without capture' do
        board = Board.new
        board.add_piece([1,1], move_pawn)
        result = move_pawn.valid_move?([1,1], [2,2], board)
        expect(result).to be(false)
      end

      it 'returns false when same piece is on capture square' do
        board = Board.new
        board.add_piece([1,1], move_pawn)
        board.add_piece([2,2], Rook.new('white', 'R'))
        result = move_pawn.valid_move?([1,1], [2,2], board)
        expect(result).to be(false)
      end
    end


    context 'when a black piece is moved' do
      subject(:move_pawn) { described_class.new('black', 'P') }
      it 'returns true if an unmoved piece if moved two clear squares forward' do
        board = Board.new
        board.add_piece([8,8], move_pawn)
        result = move_pawn.valid_move?([8,8], [8,6], board)
        expect(result).to be(true)
      end

      it 'returns true if an unmoved piece is moved one space' do
        board = Board.new
        board.add_piece([8,8], move_pawn)
        result = move_pawn.valid_move?([8,8], [8,7], board)
        expect(result).to be(true)
      end

      it 'returns false if a moved pawn tries to move two spaces' do
        board = Board.new
        board.add_piece([8,8], move_pawn)
        move_pawn.moved = true
        result = move_pawn.valid_move?([8,8], [8,6], board)
        expect(result).to be(false)
      end

      it 'returns true if a moved pawn tries to move one space' do
        board = Board.new
        board.add_piece([8,8], move_pawn)
        move_pawn.moved = true
        result = move_pawn.valid_move?([8,8], [8,7], board)
        expect(result).to be(true)
      end

      it 'returns true when diagonally capturing' do
        board = Board.new
        board.add_piece([8,8], move_pawn)
        board.add_piece([7,7], Rook.new('white', 'R'))
        result = move_pawn.valid_move?([8,8], [7,7], board)
        expect(result).to be(true)
      end

      it 'returns false when diagonally moving without capture' do
        board = Board.new
        board.add_piece([8,8], move_pawn)
        result = move_pawn.valid_move?([8,8], [7,7], board)
        expect(result).to be(false)
      end
    end 

    context 'when passed an enpassant move' do
      subject(:ep_pawn) { described_class.new('white', 'P') }

      it 'returns true' do
        board = Board.new
        board.add_piece([5,5], ep_pawn)
        board.add_piece([6,7], Pawn.new('black', 'P'))
        board.move([6,7], [6,5])
        result = ep_pawn.valid_move?([5,5], [6,6], board)
        expect(result).to be(true)
      end

      it 'removes the captured piece from the board' do
        board = Board.new
        board.add_piece([5,5], ep_pawn)
        board.add_piece([6,7], Pawn.new('black', 'P'))
        board.move([6,7], [6,5])
        ep_pawn.valid_move?([5,5], [6,6], board)
        piece = board.find_square([6,5]).piece
        expect(piece).to be(nil)
      end
    end
  end

  describe 'generate_path' do
    subject(:white_path_pawn) { described_class.new('white', 'P') }
    subject(:black_path_pawn) { described_class.new( 'black','P' ) }

    it 'returns the full path when moving two steps for white' do
      path = white_path_pawn.generate_path([1,1], [1,3])
      expect(path).to eq([[1,1],[1,2],[1,3]])
    end

    it 'returns the full path when moving two steps for white' do
      path = black_path_pawn.generate_path([8,8], [8,6])
      expect(path).to eq([[8,8],[8,7],[8,6]])
    end
  end

end


