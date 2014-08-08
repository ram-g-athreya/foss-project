setwd('/Users/ramathreya/Sites/foss-project/r');
source('predictor.R');

dataset <- read.csv(file="input.csv");
z <- read.csv(file="out.z")
z <- z[1, 'x'];
predictor_formula <- predictor(dataset);

input <- read.csv('predict-input.csv');
dataset <- rbind(dataset, input)
l <- nrow(dataset);

prediction <- predict(predictor_formula, newdata=dataset, type="response");
prediction <- (prediction[l] >= z);

fileConn<-file("output")
writeLines(c(toString(prediction)), fileConn)
close(fileConn)