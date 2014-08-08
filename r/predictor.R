predictor <- function(dataset){
  formula <- glm(
    formula = Dropout ~ cbind(Gender, Poverty, Community, Rural, PTR, SCR),
    family = binomial, 
    data = dataset);
  return(formula);
}