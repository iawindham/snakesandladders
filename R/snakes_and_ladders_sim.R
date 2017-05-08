snakes_and_ladders_sim <- function() {
  board_length <- as.integer(readline("how big of a board do you want (must be a number)? Select 0 for default size (100): "))
  if (is.na(board_length) == TRUE) {
    stop("ERROR: board length must be a number")
  }else if (board_length == 0) {
    input_board <- c(1:101)
  } else {
    input_board <- c(1:(board_length + 1))
  }
  
  die_size <- as.integer(readline("How big of a die do you want (must be a number)? Default is 6 (obviously): "))
  if (is.na(die_size) == TRUE) {
    stop("ERROR: die size must be a number")
  }
  
  turns <- as.integer(readline("How many turns do you want to simulate (again, must be a number)?  Default is 100: " ))
  if (is.na(turns) ==  TRUE) {
    stop("ERROR: turns must be a number")
  }
  
  number_of_snakesandladders <- as.integer(readline("How many ladders and snakes are there?  Select 0 to use the default pattern for the Snakes and Ladders Board Game: "))
  if (number_of_snakesandladders == 0) {
    ladders_and_snakes <- matrix(c(2,5,10,22,29,37,52,72,81,99,96,94,88,65,63,57,50,49,17,39,15,32,43,85,45,68,92,101,79,76,74,25,61,20,54,12,27,7), nrow=19)
  }
  else if (is.na(number_of_snakesandladders) == TRUE) {
   stop("ERROR: Must be a number")
  }
  else {
    ladders_and_snakes <- matrix(0, nrow = number_of_snakesandladders, ncol = 2)
    for (row in 1:number_of_snakesandladders) {
      ladders_and_snakes[row, 1] <- (as.integer(readline("From? (Enter 0 if you want to end early): ")) + 1)
      if (is.na(ladders_and_snakes[row, 1]) == TRUE) {
        stop("ERROR: Must be a number")
      }
      else if (ladders_and_snakes[row, 1] == 0) {
        break
       }
      else {
         ladders_and_snakes[row, 2] <- (as.integer(readline("To?: ")) + 1)
          if (is.na(ladders_and_snakes[row, 2]) == TRUE) {
         stop("ERROR: Must be a number")
         }
      } 
    }
  }
  #print(ladders_and_snakes)
  modified_board <- add_snakesandladders(snakematrix = ladders_and_snakes, board = input_board)
  transition_matrix <- create_transmatrix(input = modified_board, roll = die_size)
  probabilitydistribution <- markov_chain(transmat = transition_matrix, input = input_board, tau = turns)
  chance_of_finishing_game <- finish_game_chance(probabilities = probabilitydistribution, tau = turns)
  chance_of_finishing_game_plot <- ggplot(as.data.frame(chance_of_finishing_game), aes(x = seq(1, length(chance_of_finishing_game)), y = chance_of_finishing_game, )) +xlab("Number of Turns") + ylab("% chance of finishing game") + geom_line()
  print(match(max(chance_of_finishing_game), chance_of_finishing_game))
  return(chance_of_finishing_game_plot)  
}
