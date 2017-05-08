markov_chain<- function(transmat = trans, input = input_board, tau = turns) {
  probdis <- matrix(0, length(input))
  probdis[1] <- 1.0
  recorder<-matrix(0, length(tau))
  m<-0
  while (m <= tau) {
    probdis <-  t(transmat) %*% probdis
    recorder[m] <- probdis[length(input)]
    m <- m+1
  }
  return(recorder)
}