source('generateDataset.R');
source('randomizeDataset.R');

source('costFunction.R');
source('f1Score.R');

source('learningCurve.R');
source('plotLearningCurve.R');


n = 1000;
partition = 0.60;
dataset <- generateDataset(n, 0.4)

predictor <- function(dataset, z){
  formula <- glm(
    formula = Dropout ~ cbind(Gender, Poverty, Community, Rural, PTR, SCR),
                 family = binomial(logit), 
                 data = dataset);
  prediction <- predict(formula, type="response", dataset) >= z;
  return(prediction);
}

opar <- par(no.readonly=TRUE)
par(mfrow=c(3, 3))

for(i in seq(0.1, 0.9, 0.1)){
  dataset <- randomizeDataset(dataset);
  curves <- learningCurve(dataset, 10, n, 10, partition, "Dropout", predictor, i);
  plotLearningCurve(curves$m, curves$train, curves$test, c("Plot when Z is ", i), "Training Examples", "Error");
}


