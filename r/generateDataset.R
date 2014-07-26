generateDataset <- function(n, dropout_percentage){
  source('generateVector.R');
  source('percRank.R')
  
  #Gender List
  gender_list <- list(data = factor(c("Male", "Female")), 
    dist = list(Male = 0.52, Female = 0.48),
    w = list(Male = 0.39, Female = 0.41));
  
  #Poverty List
  poverty_list <- list(data = factor(c("Yes", "No")), 
                 dist = list(Yes = 0.22, No = 0.78),
                 w = list(Yes = 0.80, No = 0.27));
  
  #Community List
  community_list <- list(data = factor(c("General", "OBC", "SC", "ST")), 
                    dist = list(General = 0.30, OBC = 0.40, SC = 0.20, ST = 0.10),
                    w = list(General = 0.10, OBC = 0.48, SC = 0.64, ST = 0.69));
  
  #Rural List
  rural_list <- list(data = factor(c("Yes", "No")), 
                  dist = list(Yes = 0.75, No = 0.25),
                  w = list(Yes = 0.45, No = 0.20));
  
  #Pupil Teacher Ratio List
  ptr_list <- list(data = factor(c("Low", "Medium", "High"), order = TRUE), 
              dist = list(Low = 0.20, Medium = 0.30, High = 0.50),
              w = list(Low = 0.15, Medium = 0.35, High = 0.55));
  
  #Student Classroom Ratio List
  scr_list <- list(data = factor(c("Low", "Medium", "High"), order = TRUE), 
              dist = list(Low = 0.18, Medium = 0.33, High = 0.49),
              w = list(Low = 0.22, Medium = 0.25, High = 0.60));
  
  Gender <- generateVector(n, gender_list);
  Poverty <- generateVector(n, poverty_list);
  Community <- generateVector(n, community_list);
  Rural <- generateVector(n, rural_list);
  PTR <- generateVector(n, ptr_list);
  SCR <- generateVector(n, scr_list);
  
  getW <- function(list, vector, index){
    value <- as.character(vector[index]);
    return(as.numeric(list$w[value]));
  }
  
  weightage_vector <- vector('numeric');
  
  for(i in 1:n){
    gender_weightage = getW(gender_list, Gender, i);
    poverty_weightage = getW(poverty_list, Poverty, i);
    rural_weightage = getW(rural_list, Rural, i);
    
    weightage_vector[i] <- 
      gender_weightage + 
      poverty_weightage + 
      getW(community_list, Community, i) + 
      rural_weightage +
      getW(ptr_list, PTR, i) + 
      getW(scr_list, SCR, i) 
      #Secondary Factors
      #gender_weightage * poverty_weightage + 
      #poverty_weightage * rural_weightage +
      #gender_weightage * poverty_weightage * rural_weightage
    ;
  }
  w_rank <- percRank(weightage_vector);
  Dropout <- w_rank >= (1 - dropout_percentage);
  
  return(data.frame(Gender, Poverty, Community, Rural, PTR, SCR, Dropout));
}
