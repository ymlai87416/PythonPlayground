pollutantmean <- function(directory, pollutant, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate".
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
  ## NOTE: Do not round the result!
  
  all <- data.frame()
  for(i in id){
    temp <- read.csv(sprintf('%s/%03d.csv', directory, i))
    all <- rbind(all, temp)
  }
  tab <- names(all)
  pos <- tab==pollutant
  
  as.numeric(lapply(all[pos], mean, na.rm=TRUE))
}