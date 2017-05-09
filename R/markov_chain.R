#' Simulate markov chain for a game of Snakes and Ladders
#' 
#' \code{markov_chain} simulates a markov chain for a game of Snakes and Ladders with previously described parameters.
#' This function requires a transition matrix, and is thus meant to be used after \code{add_snakesandladders()} and \code{create_transmatrix()} 
#' in succession. \code{probdis} is initialized as a vector of 0s with the same length as the board, and \code{probdis[1]} is set to 1.
#' \code{markov_chain} takes the transpose of the transition matrix and multiplies it with the vector \code{probdis} for each turn.
#' The values contained in \code{probdis} after each multiplication correspond to the probability that a player will be on that square after that turn.
#' The vector \code{recorder} records the probability that the player will be on the final square after each turn.  This vector is used in the function \code{finish_game_chance()}
#' This is repeated for the number of turns specified in the argument \code{tau}.
#' 
#'@param transmat The transition matrix.  Must be created by the function \code{create_transmat()}
#'@param tau The number of iterations, or turns, the markov simulation is performed
#'@return The vector \code{recorder} which contains the probabilities of winning the game after each turn.  The index is the turn number, and the value is the probability.
#'@examples
#'markov_chain(transmat = create_transmatrix(), tau = 100)

markov_chain <- function(transmat, tau = turns) {
  #the probability distribution at turn 0.  The player must be in square 0 (represented as index 1) at the beginning of the game.
  #So, the probability in the first row is set to 1.0.
  probdis <- matrix(0, nrow(transmat))
  probdis[1] <- 1.0
  #A recorder vector is set up to record the probability of winning the game after each turn.
  recorder<-matrix(0, length(tau))
  m<-0
  
  while (m <= tau) {
    #Probability distribution each turn equals the transition matrix multiplied by the probability distribution at the previous turn.
    probdis <-  t(transmat) %*% probdis
    #Value of recorder at the index corresponding to the turn number is equal to the probability of winning the game at that turn.
    recorder[m] <- probdis[nrow(transmat)]
    m <- m + 1
  }
  return(recorder)
}