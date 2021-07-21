# chess

  

A command line version of the game chess, with options to play against a friend or a simple computer opponent.

  

## Instructions

  

After selecting the type of game you want to play, each player (or the human player) will be prompted for coordinates. The first number in the coordinates is the file (the numbers on the bottom), and the second is the rank:
```
♖ ♘ ♗ ♕ ♔ ♗ ♘ ♖ 8
♙ ♙ ♙ ♙ ♙ ♙ ♙ ♙ 7
W B W B W B W B 6
B W B W B W B W 5
W B W B W B W B 4
B W B W B W B W 3
♟ ♟ ♟ ♟ ♟ ♟ ♟ ♟ 2
♜ ♞ ♝ ♛ ♚ ♝ ♞ ♜ 1
1 2 3 4 5 6 7 8
```
For example, to move the king pawn, you would first enter 5, 2 when prompted. To move it two spaces ahead, you would put 5, 4:
```
♖ ♘ ♗ ♕ ♔ ♗ ♘ ♖ 8
♙ ♙ ♙ ♙ ♙ ♙ ♙ ♙ 7
W B W B W B W B 6
B W B W B W B W 5
W B W B ♟ B W B 4
B W B W B W B W 3
♟ ♟ ♟ ♟ W ♟ ♟ ♟ 2
♜ ♞ ♝ ♛ ♚ ♝ ♞ ♜ 1
1 2 3 4 5 6 7 8
```
The game also supports *en passant* and castling. For *en passant*, simply put the coordinates square where the pawn will land. For example, on the board below you would enter '6,6':
```
♖ ♘ ♗ ♕ ♔ ♗ ♘ ♖ 8
♙ ♙ ♙ ♙ ♙ W ♙ ♙ 7
W B W B W B W B 6
B W B W ♟ ♙ B W 5
W B W B W B W B 4
B W B W B W B W 3
♟ ♟ ♟ ♟ W ♟ ♟ ♟ 2
♜ ♞ ♝ ♛ ♚ ♝ ♞ ♜ 1
1 2 3 4 5 6 7 8
```
