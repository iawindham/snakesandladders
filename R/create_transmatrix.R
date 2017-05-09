#' Creates a transition matrix of probabilities for each square on the board
#' 
#' \code{create_transmatrix()} creates the transition matrix necessary to perform the markov chain simulation in the function \code{markov_chain()}.
#' A markov chain transition matrix contains all the probabilities for moving from any one board square to any other.
#' The starting square is represented by the row number, and the ending square by the column number.
#' For this simulation, however, row/column 1 represents the fictional square "0" because the game of Snakes and Ladders begins off the board rather than at square 1. 
#' Therefore, a typical 100 square Snakes and Ladders board will be represented by a 101x101 matrix.
#' 
#' @param input A vector with information about the gameboard.  Typically, this should be a board that has already been modified
#' with snake and ladder transitions via \code{add_snakesandladders()}.  However, the user can use a standard board with no snakes or ladders if they choose.
#' @param roll Indicates the number of sides on a fictional die.  Can be any number, but typically a single, six-sided die is used in-game.
#' @return a transition matrix with a number of rows and columns corresponding to the board length.  Contains the probabilities for moving from any one square to another.
#' @examples
#' create_transmatrix(input = add_snakesandladders(snakematrix = default_ladders_and_snakes, board = default_input_board), roll = 6)
#' 
create_transmatrix <- function(input, roll) {
  
  #creates an matrix of zeroes with the number of rows and columns corresponding to the length of the board
  tm <- matrix(0, nrow = length(input), ncol = length(input))
  #a vector of all possible values that can be rolled
  roll_input <- (1:roll)
  
  #These two nested loops compute a probability for each move possible from each square of the board.
  for (square in input) {
    for (moves in roll_input) {
      #Failsafe that sets the probability of moving from the finals square to the final square to 1.0
      if (square == length(input)) {
        tm[square, square] <- 1.0
        #If statement guarantees that the same of the values in any given row is not greater than 1
      } else if (sum(tm[square, ]) < 1) {
          #This if statement checks if the player is close to the end of the board, where the probability of landing on the final square is greater than 1/(die size)
          #Adds additional 1/(dize size) for subsequent rolls
          if ((square + moves) > (tail(input, n = 1)) && sum(tm[square, tail(input, n = 1)]) < 1) {
            tm[square, tail(input, n = 1)] <- (1/roll) + tm[square, tail(input, n = 1)]
          } else {
            #The probability of moving to any given square is 1/(die size)
            tm[square, input[square + moves]] <- (1/roll) + tm[square, input[square + moves]]
            }
        } 
    }
  }
  #returns transition matrix
  return(tm)
}