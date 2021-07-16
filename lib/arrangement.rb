# includes the set up array for the pieces in the game.
module Arrangement

  SET_UP_HASH = [
    { piece: Rook.new('white', '♜'),
      coord: [1, 1] },

    { piece: Knight.new('white', '♞'),
      coord: [2, 1] },

    { piece: Bishop.new('white', '♝'),
      coord: [3, 1]},

    { piece: King.new('white', '♚'),
      coord: [5, 1] },

    { piece: Queen.new('white', '♛'),
      coord: [4, 1] },

    { piece: Bishop.new('white', '♝'),
      coord: [6, 1] },

    { piece: Knight.new('white', '♞'),
      coord: [7, 1]} ,

    { piece: Rook.new('white', '♜'),
      coord: [8, 1] },

    { piece: Rook.new('black', '♖'),
      coord: [1, 8] },

    { piece: Knight.new('black', '♘'),
      coord: [2, 8] },

    { piece: Bishop.new('black', '♗'),
      coord: [3, 8] },

    { piece: King.new('black', '♔'),
      coord: [5, 8] },

    { piece: Queen.new('black', '♕'),
      coord: [4, 8] },

    { piece: Bishop.new('black', '♗'),
      coord: [6, 8] },

    { piece: Knight.new('black', '♘'),
      coord: [7, 8] },

    { piece: Rook.new('black', '♖'),
      coord: [8, 8] },

    { piece: Pawn.new('white', '♟'),
      coord: [1, 2] },

    { piece: Pawn.new('white', '♟'),
      coord: [2, 2] },

    { piece: Pawn.new('white', '♟'),
      coord: [3, 2] },

    { piece: Pawn.new('white', '♟'),
      coord: [4, 2] },

    { piece: Pawn.new('white', '♟'),
      coord: [5, 2] },

    { piece: Pawn.new('white', '♟'),
      coord: [6, 2] },

    { piece: Pawn.new('white', '♟'),
      coord: [7, 2] },

    { piece: Pawn.new('white', '♟'),
      coord: [8, 2] },

    { piece: Pawn.new('black', '♙'),
      coord: [1, 7] },

    { piece: Pawn.new('black', '♙'),
      coord: [2, 7] },

    { piece: Pawn.new('black', '♙'),
      coord: [3, 7] },

    { piece: Pawn.new('black', '♙'),
      coord: [4, 7] },

    { piece: Pawn.new('black', '♙'),
      coord: [5, 7] },

    { piece: Pawn.new('black', '♙'),
      coord: [6, 7] },

    { piece: Pawn.new('black', '♙'),
      coord: [7, 7] },

    { piece: Pawn.new('black', '♙'),
      coord: [8, 7] }
    ]

  WHITE_PIECE_ARRAY = ['♟', '♞', '♝', '♜', '♚', '♛']
  BLACK_PIECE_ARRAY = ['♙', '♘', '♗', '♖', '♔', '♕']
end
