costFunction <- function(dataset, prediction){
  m = nrow(dataset);
  J = 1 / (2 * m) * sum((dataset - prediction) ^ 2);
  return(J);
}