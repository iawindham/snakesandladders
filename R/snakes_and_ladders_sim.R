#'Runs the entire Snakes and Ladders Simulation using user specified parameters
#'
#'This prompts the user to specify all of the necessary parameters, and then runs through \code{add_snakesandladders(), create_transmatrix(), markov_chain(), and finish_game_chance()}.
#'It then prints the most probable number of turns it will take to win the game, and a graph of the output of \code{finish_game_chance()} versus the number of turns.
#'This function takes no arguments, and instead prompts the user for all the necessary parameters.
#'The default settings for the game can also be used.
#'
#'Try experimenting with different parameter settings to see what you get.
#'@return A plot of the output of \code{finishgamechance} versus the number of turns.  This distribution shows how probable it is to win the game in x number of turns.
#'@examples
#'snakes_and_ladders_sim()

snakes_and_ladders_sim <- function() {
  library(ggplot2)
  #prompts user to input board length.  Coerces input into integer value, so any decimals will be rounded down.
  board_length <- as.integer(readline("how big of a board do you want (must be a number)? Select 0 for default size (100): "))
  #Characters, which cannot be used, are coerced to NA.  Same strategy used for subsequent prompts.
  if (is.na(board_length) == TRUE) {
    stop("ERROR: board length must be a number")
  } else if (board_length == 0) {
    input_board <- default_board
  #Must add one because the board vector also includes the imaginary 0 square where the player starts (off the board).
  } else {
    input_board <- c(1:(board_length + 1))
  }
  
  die_size <- as.integer(readline("How big of a die do you want (must be a number)? Typically 6 (obviously): "))
  if (is.na(die_size) == TRUE) {
    stop("ERROR: die size must be a number")
  }
  
  turns <- as.integer(readline("How many turns do you want to simulate (again, must be a number)?  If not sure, use 100 : " ))
  if (is.na(turns) ==  TRUE) {
    stop("ERROR: turns must be a number")
  }
  
  number_of_snakesandladders <- as.integer(readline("How many ladders and snakes are there?  Select 0 to use the default pattern for the Snakes and Ladders Board Game: "))
  if (number_of_snakesandladders == 0) {
    ladders_and_snakes <- default_ladders_and_snakes
  } else if (is.na(number_of_snakesandladders) == TRUE) {
      stop("ERROR: Must be a number")
  #Adds start and endpoints of each ladder and snake one at a time, for the number specified above
  #The user can also end prematurely if they change their mind.
  } else {
      ladders_and_snakes <- matrix(0, nrow = number_of_snakesandladders, ncol = 2)
      for (row in 1:number_of_snakesandladders) {
        #One must be added to correspond to the + 1 shift in the board vector caused by the addition of the imaginary 0 square
        ladders_and_snakes[row, 1] <- (as.integer(readline("From? (Enter 0 if you want to end early): ")) + 1)
        if (is.na(ladders_and_snakes[row, 1]) == TRUE) {
          stop("ERROR: Must be a number")
        } else if (ladders_and_snakes[row, 1] == 0) {
            break
        } else {
            ladders_and_snakes[row, 2] <- (as.integer(readline("To?: ")) + 1)
            if (is.na(ladders_and_snakes[row, 2]) == TRUE) {
              stop("ERROR: Must be a number")
            }
          } 
      }
    }
  #print statement for debugging purposes
  #print(ladders_and_snakes)
  
  #Runs through all four main functions
  modified_board <- add_snakesandladders(snakematrix = ladders_and_snakes, board = input_board)
  transition_matrix <- create_transmatrix(input = modified_board, roll = die_size)
  probability_distribution <- markov_chain(transmat = transition_matrix, tau = turns)
  chance_of_finishing_game <- finish_game_chance(probabilities = probability_distribution, tau = turns)
  #plots chance_of_finishing_game versus number of turns, which corresponds to the index of chance_of_finishing_game
  chance_of_finishing_game_plot <- ggplot(as.data.frame(chance_of_finishing_game), aes(x = seq(1, length(chance_of_finishing_game)), y = chance_of_finishing_game, )) +xlab("Number of Turns") + ylab("% chance of finishing game") + geom_line()
  #Prints the most frequent number of turns at which the player will win
  print(match(max(chance_of_finishing_game), chance_of_finishing_game))
  #Returns the representative plot based on user defined parameters
  return(chance_of_finishing_game_plot)  
}
