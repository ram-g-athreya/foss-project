setwd('/Users/ramathreya/Sites/foss-project/r');

source('generateDataset.R');
source('randomizeDataset.R');
source('predictor.R');

source('costFunction.R');
source('f1Score.R');

source('learningCurve.R');
source('plotLearningCurve.R');

partition <- 0.7;
start <- 100;
interval <- 500;

dataset <- read.csv(file="input.csv");
n <- nrow(dataset);

png('../public/plot.png');

opar <- par(no.readonly=TRUE)
par(mfrow=c(3, 3));

z <- c();
train <- c();
cv <- c();
f1 <- c();

seq_range <- seq(0.1, 0.9, 0.1);
for(i in seq_range){
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
min_index <- which(w==min(w));
write.csv(seq_range[min_index], file="out.z")
  
dev.off();
