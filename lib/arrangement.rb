module Arrangement

  SET_UP_HASH = [
    { piece: Rook.new('white', '♜'),
      coord: [1, 1] },

    { piece: King.new('white', '♚'),
      coord: [4, 1] },

    { piece: Rook.new('white', '♜'),
      coord: [8, 1] },

    { piece: Bishop.new('white', '♝'),
      coord: [3, 1]},

    { piece: Bishop.new('white', '♝'),
      coord: [6, 1]},

    { piece: Rook.new('black', '♖'),
      coord: [1, 8]},

    { piece: King.new('black', '♔'),
      coord: [4, 8]},

    { piece: Rook.new('black', '♖'),
      coord: [8,8]},

    { piece: Bishop.new('black', '♗'),
      coord: [3, 8]},
  
    { piece: Bishop.new('black', '♗'),
      coord: [6, 8]}
    ]

  WHITE_PIECE_ARRAY = ['♚','♛','♝','♞','♟','♜']
  BLACK_PIECE_ARRAY = ['♗','♘','♙','♔','♕','♖']
end
