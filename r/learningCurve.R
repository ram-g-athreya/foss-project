learningCurve <- function(dataset, start, end, interval, partition, column, predictor, z){
  train_plot <- c();
  test_plot <- c();
  x <- c();
  
  for(i in seq(start, end, interval)){
    m <- i * partition;
    
    training_dataset <- dataset[1:m, ];
    test_dataset <- dataset[(m+1):i, ];
    
    train_actual <- training_dataset[column];
    test_actual <- test_dataset[column];
    
    train_pred <- predictor(training_dataset, z);
    test_pred <- predictor(training_dataset, z);
    
    train_cost <- costFunction(train_actual, train_pred); 
    test_cost <- costFunction(test_actual, test_pred);  
    
    x <- c(x, i);
    train_plot <- c(train_plot, train_cost);
    test_plot <- c(test_plot, test_cost);
  }
  return(list(train=train_plot, test=test_plot, m=x));
}

