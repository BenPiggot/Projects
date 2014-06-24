rankhospital <- function(state, outcome, num = "best"){
  setwd("~/Desktop/Medicare_Hospital_Data")
  my_data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  hospital_data <- my_data[,c(2,7,11,17,23)]
  hospital_data[hospital_data=="Not Available"]  <- NA
  hospital_data <- hospital_data[complete.cases(hospital_data),]
  hospital_data[,3] <- as.numeric(hospital_data[,3])
  hospital_data[,4] <- as.numeric(hospital_data[,4])
  hospital_data[,5] <- as.numeric(hospital_data[,5])
  states <- hospital_data[,2]
  causes <- c("heart attack", "heart failure", "pneumonia")
  names(hospital_data) <- c("hospital","state", "heart attack", "heart failure", "pneumonia")
  if(!outcome %in% causes) {stop("invalid outcome")}  
  if(!state %in% states) {stop("invalid state")}
  state_rank <- hospital_data[hospital_data$state == state,]
  if (num == "best"){
     if (outcome == "heart attack"){    
	 ordered <- state_rank[order(state_rank[,3],state_rank[,1]),]
	 x <- ordered[1,1]
}
     if (outcome == "heart failure"){
	 ordered <- state_rank[order(state_rank[,4],state_rank[,1]),]
	 x <- ordered[1,1]
}
     if (outcome == "pneumonia"){
	 ordered <- state_rank[order(state_rank[,5],state_rank[,1]),]
	 x <- ordered[1,1]
}
}
  else if (num == "worst"){
     if (outcome == "heart attack"){    
	 ordered <- state_rank[order(state_rank[,3],state_rank[,1]),]
	 x <- ordered[nrow(ordered),1]
}
     if (outcome == "heart failure"){
	 ordered <- state_rank[order(state_rank[,4],state_rank[,1]),]
	 x <- ordered[nrow(ordered),1]
}
     if (outcome == "pneumonia"){
	 ordered <- state_rank[order(state_rank[,5],state_rank[,1]),]
	 x <- ordered[nrow(ordered),1]
}
 } 
  else {
     if (outcome == "heart attack"){    
	 ordered <- state_rank[order(state_rank[,3],state_rank[,1]),]
	 x <- ordered[num,1]
}
     if (outcome == "heart failure"){
	 ordered <- state_rank[order(state_rank[,4],state_rank[,1]),]
	 x <- ordered[num,1]
}
     if (outcome == "pneumonia"){
	 ordered <- state_rank[order(state_rank[,5],state_rank[,1]),]
	 x <- ordered[num,1]
}
}
return(x)
}