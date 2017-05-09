#'Applies snake and ladder transitions to the board.  
#'
#'\code{add_snakesandladders()} applies the start and end points of all of the snakes and ladders on the board.
#'The input is stored in a two column matrix, which can be assigned manually or through the function \code{snakes_and_ladders_sim}.  
#Column one lists the starting points of every snake and ladder, and the endpoints are listed on the same row in the second column.
#'This function changes the numbers on the board to match where each snake or ladders ends.
#'For example, if a snake leads from square 55 to square 32, then the number 55 in the board vector is replaced by 32.
#'
#' @param snakematrix A two column matrix listing the starting points of snakes/ladders in the left column and the endpoints in the right
#' @param board A vector of all numbers from 1 to the length of the board.  Index represents board position, value represents what square you end up on in that position
#' @return A new board vector with values replaced corresponding to the locations of snakes and ladders
#' @examples
#' add_snakesandladders(snakematrix = default_ladders_and_snakes, board = default_input_board)

#arguments for this function can come from user input via snakes_and_ladders_sim()
add_snakesandladders <- function(snakematrix, board) {
  #This loop deals with instances of when there are overlapping snakes or ladders.  
  #An example would be a snake going from 59 to 31, and another going from 31 to 12
  #This loop removes the intermediary, so both 59 and 31 go to 12
  for (col1 in 1:length(snakematrix[ , 1]) ) {
    for (col2 in 1:length(snakematrix[ , 2]) ) {
      if (snakematrix[col2, 2] == snakematrix[col1, 1]) {
        snakematrix[col2, 2] <- snakematrix[col1, 2]
      }
    }
  }
  #This loop replaces a value in board if it matches a value in the first column of snakematrix.
  #Matching value in column 1 is replaced by the corresponding endpoint in column 2
  for (ladder_or_snake in 1:length(snakematrix[ ,1])) {
    board <- replace(board, board == snakematrix[ladder_or_snake, 1], snakematrix[ladder_or_snake, 2])
  }
  #returns modified board vector
  return(board)
}