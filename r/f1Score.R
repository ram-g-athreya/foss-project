f1Score = function(data, prediction){
  data <- as.numeric(data);
  prediction <- as.numeric(prediction);
  
  true_positives <- sum(data);
  false_positives <- sum(prediction == !data & prediction);
  false_negatives <- sum(data == !prediction & !prediction);
  
  precision <- true_positives / (true_positives + false_positives);
  recall <- true_positives / (true_positives + false_negatives);
  
  return(as.numeric(2 * precision * recall / (precision + recall)));
}