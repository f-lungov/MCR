ini <- function(){

  	# This function will set everything up, so the user can later call MCR.

	# loads required packages
	require(xlsx)
	
	# sources the R files that will be used
	source("runMCR.R") # calls MCR
	source("importData.R") # loads data from an excel file
	source("keepRunning.R") # decides whether another regression should be run
	source("findX.R") # where each f is randomly picked and X is calculated
	source("writeEquations.R") # writes out the equations in human readable format
	source("fetchHistory.R") # fetches all data in one of the history files

}