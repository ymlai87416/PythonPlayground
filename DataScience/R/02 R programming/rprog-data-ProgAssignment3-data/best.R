best <- function(state, outcome){
    ## Read outcome data
    data <- read.csv("outcome-of-care-measures.csv", colClasses="character")
    ## Check that state and outcome are valid
    data[, 7] <- as.character(data[, 7])
    statef <- (data[,7] == state)
    data <- data [statef,]
    
    if(nrow(data) == 0){
      stop("invalid state")
    }
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
    ## Return hospital name in that state with lowest 30-day death rate
    sortdata <- data[order(data[y]), ]
    sortdata[1,2]
}