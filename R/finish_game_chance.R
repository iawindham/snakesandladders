finish_game_chance <- function (probabilities = dist, tau=turns) {
  finishchance<-numeric(tau-1)
  for (chance in 1:(length(probabilities)-1)) {
    finishchance[chance+1] <- (probabilities[chance+1] - probabilities[chance]) *100
  }
  return(finishchance)
}