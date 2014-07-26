generateVector <- function(n, list){
  dist <- list$dist;
  p <- c(length(list$data));
  
  #Generate probability series
  k = 1;
  for(i in dist){
    if(k == 1){
      p[k] = i;
    }
    else{
      p[k] = i + p[k - 1];
    }
    k = k + 1;
  }
  
  #Get index of value that will be added to the vector
  getIndex <- function(p, r){
    k = 1;
    for(i in p){
      if(r <= i){
        break;
      }
      k = k + 1;
    }
    return(k);
  }
  
  #Generate Vector
  result <- factor(list$data);
  for(i in 1:n) {
    index <- getIndex(p, runif(1));
    value <- list$data[index];
    result[i] = value;
  }
  
  return(result);
}