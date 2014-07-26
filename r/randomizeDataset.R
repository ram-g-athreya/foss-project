randomizeDataset <- function(dataset){
  result <- subset(dataset, FALSE);
  l <- nrow(dataset);
  s <- sample(seq(1, l), l);
  
  for(i in 1:l){
    result[i, ] <- dataset[s[i], ];
  }
  return(result);
}