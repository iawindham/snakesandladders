dat<-data.frame(replicate(20,sample(c("A", "B", "C","D"), size = 100, replace=TRUE)))

trans.matrix <- function(X, prob=T)
{
  tt <- table( c(X[,-ncol(X)]), c(X[,-1]) )
  if(prob) tt <- tt / rowSums(tt)
  tt
}