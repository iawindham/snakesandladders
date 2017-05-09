#'Calculates the probability of winning the game after a certain number of moves
#'
#'This function takes the probabilities of winning the game after each turn, the vector returned by \code{markov_chain()}
#'and calculates the probability that the game will be won BY each turn.  This is essentially the derivative of the graph of 
#'number of turns versus the probability of winning the game after each turn.  The function calculates the difference between each
#'two consecutive entries in the input vector, multiplied by 100, and returns a vector of the probabilities of winning by each turn.
#'The vector returned by this function can be graphed versus the number of turns, and the index of the maximum value is the turn that
#'a player has the greatest chance of winning on.  In the case of the default board, for example, players have the highest chance of winning on turn 19.
#'
#'@param probabilities The probabilities of winning the game after each turn.  This is the vector returned by the function \code{markov_chain()}
#'@param tau The number of iterations, or turns.  Must be the same as the value used in \code{markov_chain()}
#'@return A vector of the probability of that the game will be won at each turn.
#'@examples
#'finish_game_chance(probabilities = markov_chain(), tau = 100)
finish_game_chance <- function (probabilities, tau = turns) {
  #An empty vector with the same size as the the number of turns, minus one.
  #One is subtracted because the entries in finishchance are the differences between the entries of probabilities
  #Thus, there will be one fewer entry
  finishchance<-numeric(tau - 1)
  
  #Calculates the difference of each pair of consecutive entries in probabilities and adds them to finishchance
  for (chance in 1:(length(probabilities) - 1)) {
    finishchance[chance + 1] <- (probabilities[chance + 1] - probabilities[chance]) * 100
  }
  #Returns a vector of the probabilities of the game being completed at each turn
  return(finishchance)
}