source('generateDataset.R');
source('costFunction.R');
source('f1Score.R');

source('learningCurve.R');


n = 1000;
dataset <- generateDataset(n, 0.4)

predictor <- function(){
  print("Comes here");
}

#learningCurve(dataset, 100, n, 100, 0.8, predictor);



k = 0.8 * n;

training_dataset <- dataset[1:k, ];
test_dataset <- dataset[(k+1):n, ];
dropout = test_dataset$Dropout;




formula <- glm(formula = Dropout ~ cbind(Gender, Poverty, Community, Rural, PTR, SCR),
               family = binomial(logit), 
               data = training_dataset);





x <- matrix(, nrow=0, ncol=2);
for(i in seq(0.1, 1, 0.1)){
  prediction <- predict(formula, type="response", test_dataset) >= i;
  #perf <- f1Score(dropout, prediction);
  perf <- costFunction(dropout, prediction);
  x <- rbind(x, c(i, perf));
}

plot(x);
