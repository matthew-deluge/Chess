* Notes on Algebraic Notation:

Each square of the chessboard is identified by a unique coordinate pair—a letter and a number—from White's point of view. The vertical columns of squares, called files, are labeled a through h from White's left (the queenside) to right (the kingside). The horizontal rows of squares, called ranks, are numbered 1 to 8 starting from White's side of the board. Thus each square has a unique identification of file letter followed by rank number. For example, the initial square of White's king is designated as "e1".

Numbers up, letters across

* Piece Types:
K - King
Q - Quee
R - Rook
B - Bishop
N - Knight

Pawns have symbol - their piece is not included in the notation

* Captures
When a piece makes a capture, an x is inserted BEFORE the destination square (Bxe5 - Bishop captures e5 piece)

en passant is somtimes included as a suffix e.p. (seems optional)

* Disambiguating moves
When two or more peices can move to the same square, you first specify the pieces letter, then:
- the file of departure (if they differ); or
- the rank of departure (if the files are the same but the ranks differ); or
- both the file and rank of departure (if neither alone is sufficient to identify the piece—which occurs only in rare cases where a player has three or more identical pieces able to reach the same square, as a result of one or more pawns having promoted).

* Pawn Promotion
To show the pawn promotion, attach the letter of the new piece to the end

* Castling
Use 0-0 for kingside and 0-0-0 for queenside

* Check
use a + on the end to show check

* Checkmate
use a # on the end

* end of game
 - white win: 1-0
 - black win: 0-1

* Rules to remember:
- en passant
- check
- ugrading pawns
- castleing
- draws
- 50 move limit



* Review of "Knight's Travails

For knights travails, the goal was a program that took in an initial position for a knight piece, took in a target position, and then found the shortest path between those two positions

The different pieces I coded for this were:
- first I made a "node" class. This had two init variables:data (or the value) and neighbors
- Then, I made the board class, which was an array of the different possible positions on a chess board [(1-8), (1-8)]
- next, I made a knight piece that only had one method: valid_move, which when passed two coordinates would return true if the knight could move from one to the other
- Then, I made the "grid". This became a kind of catchall category and did most of the "thinking" for the project. This created a graph, where a node was created for each coordinate in an 8X8 board. It then went through each node, and if a knight could move from one to another node on the list, it would add that reachable node as a neighbor. Once all of the neighbors were sorted out, it used a breadth first search to find the shortest path between the two spaces

Some things to use directly from this:
- The idea of spaces as nodes
- Using number coordinates to caluclate if a move is legal (will have to create a conversion system)
- If creating an AI, the breadth first search may come in handy, though it seems unlikely

Some ideas from this
- making an overall piece class, then having each actual piece inherit from it
- Having each square be a node held in a larger board class - each node would need coordinates, if it is currently occupied, what piece is on it


Different Pieces to Build:
- Piece Class with valid_move?, symbol
- individual piece classes: pawn, knight, bishop, rook, king, queen
- square class with values: coordinates, piece, occupied?, color
- Board class with: array of squares, way to check for check, way to track moves, taken moves
- game class that creates board, takes moves, and updates board, overall play function
- display module that will display a board's current state
- Notation convertor module that converts from coordinates to algebraic notation
- save module that saves the state as a JSON and can restore the game

To Do's:
- Write piece class
- write rook piece
- test rook piece
- write square class
- write board class
- create simple game with only rook
- test!
- create simple display
- Write king class
- Create simple game with king and queen
- test!
- Write  class for other pieces
- test for all togehter
- refine display module
- write notation convertor
- write save module



