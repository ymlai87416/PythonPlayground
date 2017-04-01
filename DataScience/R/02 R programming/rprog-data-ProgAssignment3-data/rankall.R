rankall <- function(outcome, num="best"){
  
  #inner function
  rankhospital <- function(data, y, num="best"){
    
    ## Check that state and outcome are valid
    data[, 7] <- as.character(data[, 7])
    
    data[, 11] <- as.numeric(data[, 11])
    data[, 17] <- as.numeric(data[, 17])
    data[, 23] <- as.numeric(data[, 23])
    
    num <- if(num == "best"){
      1
    } else if (num == "worst"){
      nrow(data)
    } else {
      num
    }
    sortdata <- data[order(data[y], data[2]), ]
    c(sortdata[num,2],sortdata[1, 7])
  }
  
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv", colClasses="character")
  ## Check that state and outcome are valid
  data[, 7]  <- as.character(data[, 7])
  data[, 11] <- as.numeric(data[, 11])
  data[, 17] <- as.numeric(data[, 17])
  data[, 23] <- as.numeric(data[, 23])
  
  y <- if(outcome=="heart attack"){
    11
  } else if(outcome=="heart failure"){
    17
  } else if(outcome=="pneumonia"){
    23
  } else {
    stop("invalid outcome")
  }
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  nafilter <- (!is.na(data[, y]))
  data <- data[nafilter,]
  
  ##Start at this
  splitDate <- split(data, data$State)
  result <- lapply(splitDate, rankhospital, y, num)  
  result <- data.frame(Reduce(rbind, result))
  colnames(result) <- c("hospital", "state")
  rownames(result) <- result$state
  
  result
}