rankall <- function(outcome, num){
  setwd("~/Desktop/Medicare_Hospital_Data")
  my_data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  hospital_data <- my_data[,c(2,7,11,17,23)]
  hospital_data[hospital_data=="Not Available"]  <- NA
  hospital_data[,3] <- as.numeric(hospital_data[,3])
  hospital_data[,4] <- as.numeric(hospital_data[,4])
  hospital_data[,5] <- as.numeric(hospital_data[,5])
  names(hospital_data) <- c("hospital","state", "heart attack", "heart failure", "pneumonia")
  x <- split(hospital_data, hospital_data$state)
  state <- sort(unique(hospital_data$state))
  causes <- c("heart attack", "heart failure", "pneumonia")
  if(!outcome %in% causes) {stop("invalid outcome")}  
  hospital <- c()
  for (i in 1:length(x)){
    if (num == "best"){
      if (outcome == "heart attack"){
        z <- x[[i]]
        data.frame(z)
        ordered <- z[order(z[,3],z[,1],na.last=NA),]
        y <- ordered[,c(1,3)]
        a <- y[1,1]
      }
      if (outcome == "heart failure"){
        z <- x[[i]]
        data.frame(z)
        ordered <- z[order(z[,4],z[,1],na.last=NA),]
        y <- ordered[,c(1,4)]
        a <- y[1,1]
      }
      if (outcome == "pneumonia"){
        z <- x[[i]]
        data.frame(z)
        ordered <- z[order(z[,5],z[,1],na.last=NA),]
        y <- ordered[,c(1,5)]
        a <- y[1,1]
      }
    }
    else if (num == "worst"){
      if (outcome == "heart attack"){ 
        z <- x[[i]]
        data.frame(z)  
        ordered <- z[order(z[,3],z[,1],na.last=NA),]
        y <- ordered[,c(1,3)]
        a <- y[nrow(y),1]
      }
      if (outcome == "heart failure"){ 
        z <- x[[i]]
        data.frame(z)  
        ordered <- z[order(z[,4],z[,1],na.last=NA),]
        y <- ordered[,c(1,4)]
        a <- y[nrow(y),1]
      }
      if (outcome == "pneumonia"){ 
        z <- x[[i]]
        data.frame(z)  
        ordered <- z[order(z[,5],z[,1],na.last=NA),]
        y <- ordered[,c(1,5)]
        a <- y[nrow(y),1]
      }
    }
    else {
      if (outcome == "heart attack"){ 
        z <- x[[i]]
        data.frame(z)   
        ordered <- z[order(z[,3],z[,1],na.last=NA),]
        y <- ordered[,c(1,3)]
        a <- y[num,1]
      }
      if (outcome == "heart failure"){
        z <- x[[i]]
        data.frame(z)   
        ordered <- z[order(z[,3],z[,1],na.last=NA),]
        y <- ordered[,c(1,4)]
        a <- y[num,1]
      }
      if (outcome == "pneumonia"){
        z <- x[[i]]
        data.frame(z)   
        ordered <- z[order(z[,3],z[,1],na.last=NA),]
        y <- ordered[,c(1,5)]
        a <- y[num,1]
      }
    }
    hospital <- append(hospital,a)
  }
  final <- cbind(hospital,state)
  final_table <- data.frame(final)
  return(final_table)
}