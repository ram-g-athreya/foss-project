costFunction <- function(dataset, prediction){
  dataset <- as.numeric(dataset);
  prediction <- as.numeric(prediction);
  m = length(dataset);
  J = 1 / (2 * m) * sum((dataset - prediction) ^ 2);
  return(J);
}