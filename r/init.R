source('generateDataset.R');
source('randomizeDataset.R');

source('costFunction.R');
source('f1Score.R');

source('learningCurve.R');
source('plotLearningCurve.R');


n <- 2100;
partition <- 0.75;
start <- 100;
interval <- 500;

data <- generateDataset(n, 0.4)
write.csv(file="data.csv", x=data)
#data <- read.csv(file="data.csv")

dataset <- data
predictor <- function(dataset){
  formula <- glm(
    formula = Dropout ~ cbind(Gender, Poverty, Community, Rural, PTR, SCR),
                 family = binomial, 
                 data = dataset);
  return(formula);
}

opar <- par(no.readonly=TRUE)
par(mfrow=c(3, 3));

z <- c();
train <- c();
cv <- c();
f1 <- c();

for(i in seq(0.1, 0.9, 0.1)){
  dataset <- randomizeDataset(dataset);
  curves <- learningCurve(dataset, start, n, interval, partition, "Dropout", predictor, i);
  plotLearningCurve(curves$m, curves$train, curves$test, c("Plot when Z is ", i), "Training Examples", "Error");
  
  train_last <- tail(curves$train, 1);
  cv_last <- tail(curves$test, 1);
  
  z <- c(z, i);
  cv <- c(cv, sum(abs(curves$test)) / length(curves$test));
  train <- c(train, sum(abs(curves$train)) / length(curves$train));
  f1 <- c(f1, sum(abs(curves$f1)) / length(curves$f1));
}

w <- (1-f1) * train * cv;

analysis <- data.frame(z, train, cv, f1, w);
print(analysis);

