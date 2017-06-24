complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  
  all <- data.frame(id=numeric(0), nobs=numeric(0))
  
  for(i in id){
    temp <- read.csv(sprintf('%s/%03d.csv', directory, i))
    pos <- !is.na(temp$Date) & !is.na(temp$sulfate) & !is.na(temp$nitrate) & !is.na(temp$ID)
    all <- rbind(all, c(i, nrow(temp[pos, ])))
  }
  
  names(all) <- c("id", "nobs")
  all
}
