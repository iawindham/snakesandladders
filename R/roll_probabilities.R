#'Runs the simulation for a a range of die sizes
#'
#'The function was just an additional little experiment I wanted to try, and is not part of the core functions of the package.
#'\code{roll_probabilities} creates a new transition matrix, runs the markov chain simulation, and produces a new probability distribution
#'for each die size in the range.  The maximum value of the output of \code{finish_game_chance} is recorded in the vector \code{optimizedroll}.
#'This produces an interesting graph structure when plotted versus the die size.
#'
#'@param maxroll The maximum dize.  Essentially, the number of iterations of this function.
#'@return A plot of the die size versus the max values of the vector returned by \code{finish_game_chance} after each simulation.
#'@examples
#'roll_probabilities(maxroll = 100)



roll_probabilities <- function(maxroll = 100) {
  #creates an empty vector of size maxroll.  This will be filled in the subsequent for loop and returned.
  optimizedroll<-numeric(maxroll)
  #This for loops runs through the creation of the transition matrix, the markov chain, and the derivatation for each die size
  #Applies the max value of the output of finish_game_chance to each entry in optimizedroll
  for (movemax in 1:maxroll) {
    itertrans<-create_transmatrix(input = modified_board, roll = movemax)
    iterdist<-markov_chain(transmat = itertrans, tau = 100)
    optimizedroll[movemax]<-max(finish_game_chance(probabilities = iterdist, tau = 100))
  }
  optimizedrollgraph <-
    ggplot(as.data.frame(optimizedroll), aes(x = seq(1, length(optimizedroll)), y = optimizedroll)) +
    xlab("Die size") +
    ylab("% chance of finishing game at most probable winning turn") +
    geom_line()
  return(optimizedrollgraph)
}
