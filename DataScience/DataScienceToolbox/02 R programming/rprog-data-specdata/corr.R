corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  ## NOTE: Do not round the result!

  result <- numeric()
  i <- 0 
  
  while(file.exists(sprintf('%s/%03d.csv', directory, i<-i+1))){
    temp <- read.csv(sprintf('%s/%03d.csv', directory, i))
    pos <- !is.na(temp$Date) & !is.na(temp$sulfate) & !is.na(temp$nitrate) & !is.na(temp$ID)
    if(sum(pos) < threshold || sum(pos) == 0) next
    temp <- temp[pos, ]
    result <- c(result, cor(temp$sulfate, temp$nitrate))
  }
  
  result
}