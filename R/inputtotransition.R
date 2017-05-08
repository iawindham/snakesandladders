#vector representing initial board input
board <-c(1:101)# c(1:9)#
#input matrix detailing locations of snakes and ladders
snakes_and_ladders <- matrix(c(2,5,10,22,29,37,52,72,81,99,96,94,88,65,63,57,50,49,17,39,15,32,43,85,45,68,92,101,79,76,74,25,61,20,54,12,27,7), nrow=19)#matrix(c(20, 12, 8, 2, 10, 35, 31, 18, 12, 3, 23, 21, 29, 27, 5, 21), nrow=8) #matrix(c(3,5,4,8), nrow=2)
#max move distance
dice <- 6
turn_number<-200
#applies snakes and ladders to input matrix


add_snakes <- function(snakematrix = snakes_and_ladders, input = board) {
  #options(error=utils::recover) 

  for (col1 in 1:length(snakematrix[, 1]) ) {
    for (col2 in 1:length(snakematrix[, 2]) ) {
      if (snakematrix[col2, 2] == snakematrix[col1, 1]) {
        snakematrix[col2, 2] <- snakematrix[col1, 2]
      }
    }
  }
  print(snakematrix)
  for (iter in 1:length(snakematrix[,1])) {
  input <- replace(input, input == snakematrix[iter, 1], snakematrix[iter, 2])
  }
  return(input)
}

fixedboard<-add_snakes()

#creates transition matrix
create_tm <- function(input = fixedboard, roll = dice) {
  tm <- matrix(0, nrow = length(input), ncol = length(input))
  i<-1
  roll_input <- (1:roll)
  for (i in input) {
   j<-1
    for (j in roll_input) {
      if (i == length(input)) {
        tm[i, i] <- 1.0
      }
      else if (sum(tm[i, ]) < 1) {
       if ((i+j) > (tail(input, n=1)) && sum(tm[i, tail(input, n=1)]) < 1) {
           tm[i, tail(input, n=1)] <- (1/roll) + tm[i, tail(input, n=1)]
       }
       else {
       tm[i, input[i + j]] <- (1/roll) + tm[i, input[i + j]]
       }
     }
    }
  }
  #tm[length(input), length(input)] <- 1
  #tm <- tm[which(rowSums(tm) > 0),which(colSums(tm) > 0)]
  return(tm)
}

trans <- create_tm()

markov_chain<- function(transmat = trans, input = board, tau = turn_number) {
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

dist<-markov_chain()

finish_game_chance <- function (probabilities = dist, tau=turn_number) {
  finishchance<-numeric(tau-1)
  for (chance in 1:(length(probabilities)-1)) {
    finishchance[chance+1] <- (probabilities[chance+1] - probabilities[chance]) *100
  }

  return(finishchance)
}
numberofturnschance <- finish_game_chance()
numberofturnsplot <- ggplot(as.data.frame(numberofturnschance), aes(x = seq(1, length(numberofturnschance)), y = numberofturnschance, )) + geom_line()
#print(numberofturnsplot)

rolloptimizer <- function(maxroll = 100) {
  optimizedroll<-numeric(maxroll)
  for (movemax in 1:maxroll) {
    itertrans<-create_tm(roll = movemax)
    iterdist<-markov_chain(transmat = itertrans)
    optimizedroll[movemax]<-max(finish_game_chance(probabilities = iterdist))
  }
  return(optimizedroll)
}

#letssee<-rolloptimizer()
#rolloptimizerplot <- ggplot(as.data.frame(letssee), aes(x = seq(1, length(letssee)), y = letssee)) + geom_line()
#print(rolloptimizerplot)