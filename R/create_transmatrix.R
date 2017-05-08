#creates transition matrix
create_transmatrix <- function(input = fixedboard, roll = dice) {
  tm <- matrix(0, nrow = length(input), ncol = length(input))
  roll_input <- (1:roll)
  for (square in input) {
    for (moves in roll_input) {
      if (square == length(input)) {
        tm[square, square] <- 1.0
      }
      else if (sum(tm[square, ]) < 1) {
        if ((square+moves) > (tail(input, n=1)) && sum(tm[square, tail(input, n=1)]) < 1) {
          tm[square, tail(input, n=1)] <- (1/roll) + tm[square, tail(input, n=1)]
        }
        else {
          tm[square, input[square + moves]] <- (1/roll) + tm[square, input[square + moves]]
        }
      }
    }
  }
  #tm <- tm[which(rowSums(tm) > 0),which(colSums(tm) > 0)]
  return(tm)
}