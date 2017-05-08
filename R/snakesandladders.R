snakes_and_ladders_sim <- function()
  board_length <- prompt("how big of a board do you want (must be integer)? Select 0 for default size (100)")
  if (is.integer(board_length) ==  FALSE) {
    stop("ERROR: board length must be an integer")
  }
  else if (board_length == 0) {
    input_board <- c(1:101)
  }
  else {
    input_board <- c(1:(board_length + 1))
  }
  
  die_size <- prompt("How big of a die do you want (must be integer)? Default is 6 (obviously)")
  if (is.integer(die_size) == FALSE) {
    stop("ERROR: die size must be integer")
  }
  
  
  