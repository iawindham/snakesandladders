roll_probabilities <- function(maxroll = 100) {
  optimizedroll<-numeric(maxroll)
  for (movemax in 1:maxroll) {
    itertrans<-create_tm(roll = movemax)
    iterdist<-markov_chain(transmat = itertrans)
    optimizedroll[movemax]<-max(finish_game_chance(probabilities = iterdist))
  }
  return(optimizedroll)
}