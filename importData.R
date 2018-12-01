importData <- function(useCase){
      
	# This function will load the data into X and Zs.
	
	# useCase: the use case being run; there must be a directory with the same name
	
	# loads Excel file into a dataframe
	dataAll <- read.xlsx(paste(useCase, "/raw-data.xlsx", sep=''), sheetName="tidyup data")

	dataN <- dataAll[,1] # observation names
  dataY <- dataAll[,2] # y
  dataZs <- dataAll[,3:ncol(dataAll)] # z
  
  dataY <- as.numeric(dataY)
  # dataY <- (dataY-min(dataY))/(max(dataY)-min(dataY)) # converts to 0:1 range
  names(dataY) <- dataN

  dataZs <- as.matrix(dataZs)
  # dataZs <- apply(dataZs, 2, function(x)(x-min(x))/(max(x)-min(x))) # converts all Z variables to 0:1 range
  # dataZs <- dataZs * 99 + 1 # converts all Z variables to 1:99 range, since we can't have dividing zeroes
  rownames(dataZs) <- dataN
  
  list(zs=dataZs, y=dataY)
            
}