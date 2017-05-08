add_snakesandladders <- function(snakematrix = ladders_and_snakes, board = input_board) {
  for (col1 in 1:length(snakematrix[, 1]) ) {
    for (col2 in 1:length(snakematrix[, 2]) ) {
      if (snakematrix[col2, 2] == snakematrix[col1, 1]) {
        snakematrix[col2, 2] <- snakematrix[col1, 2]
      }
    }
  }
  for (ladder_or_snake in 1:length(snakematrix[,1])) {
    board <- replace(board, board == snakematrix[ladder_or_snake, 1], snakematrix[ladder_or_snake, 2])
  }
  return(board)
}
