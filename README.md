# chess

  

A command line version of the game chess, with options to play against a friend or a simple computer opponent. Built for [The Odin Project FInal Ruby Project](https://www.theodinproject.com/paths/full-stack-ruby-on-rails/courses/ruby-programming/lessons/ruby-final-project).

  

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
The game will run until one of the players is in checkmate, or there is a draw.

## Special Moves

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
And the pawn will be captured as part of the move:

```
♖ ♘ ♗ ♕ ♔ ♗ ♘ ♖ 8
♙ ♙ ♙ ♙ ♙ W ♙ ♙ 7
W B W B W ♟ W B 6
B W B W B W B W 5
W B W B W B W B 4
B W B W B W B W 3
♟ ♟ ♟ ♟ W ♟ ♟ ♟ 2
♜ ♞ ♝ ♛ ♚ ♝ ♞ ♜ 1
1 2 3 4 5 6 7 8
```
For castling, if it is a legal move you can select the king and then enter the coordinates of the square where it will end up. For example on this board, entering '5,1' then '5,7' will castle on the king side:

```
♖ ♘ ♗ ♕ ♔ B ♘ ♖ 8
♙ ♙ ♙ W B ♙ ♙ ♙ 7
W B W B ♙ B W B 6
B W ♗ ♙ B W B W 5
W B ♝ B W B W B 4
B W B W ♟ W B ♞ 3
♟ ♟ ♟ ♟ W ♟ ♟ ♟ 2
♜ ♞ ♝ ♛ ♚ W B ♜ 1
1 2 3 4 5 6 7 8
```
And the resulting board will look like this:

```
♖ ♘ ♗ ♕ ♔ B ♘ ♖ 8
♙ ♙ ♙ W B ♙ ♙ ♙ 7
W B W B ♙ B W B 6
B W ♗ ♙ B W B W 5
W B ♝ B W B W B 4
B W B W ♟ W B ♞ 3
♟ ♟ ♟ ♟ W ♟ ♟ ♟ 2
♜ ♞ ♝ ♛ B ♜ ♚ W 1
1 2 3 4 5 6 7 8
```

## Saving

In game, if you want to take a break, simply type 'save' when prompted to select a piece. This will save the game and exit the program. When you start the program the next time, you will be able to choose to load that game as either as a two player game or a versus computer game. Please note you can only save one game at a time. 