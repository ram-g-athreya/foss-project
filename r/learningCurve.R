learningCurve <- function(dataset, start, end, interval, partition, column, predictor, z){
  train_plot <- c();
  test_plot <- c();
  x <- c();
  
  f1 <- c();
  
  for(i in seq(start, end, interval)){
    m <- i * partition;
    
    training_dataset <- dataset[1:m, ];
    test_dataset <- dataset[(m+1):i, ];
    
    train_actual <- unlist(training_dataset[column]);
    test_actual <- unlist(test_dataset[column]);
    predictor_formula <- predictor(training_dataset);
      
    train_pred <- predict(predictor_formula, type="response", training_dataset) >= z;
    test_pred <- predict(predictor_formula, type="response", test_dataset) >= z;
    
    train_cost <- costFunction(train_actual, train_pred); 
    test_cost <- costFunction(test_actual, test_pred);  
    
    f1 <- c(f1, f1Score(test_actual, test_pred));
    
    x <- c(x, i);
    train_plot <- c(train_plot, train_cost);
    test_plot <- c(test_plot, test_cost);
  }
  return(list(train=train_plot, test=test_plot, m=x, f1=f1));
}

