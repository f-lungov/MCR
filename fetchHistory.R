fetchHistory <- function(useCase, histFile="default"){
	
	# This function fetches a history file and all data in it.
	
	# useCase: the use case being run; there must be a directory with the same name
	# histFile: file with history of top regressions found so far

	histFile <- paste(useCase, '/regressions/', histFile, '.RData', sep='')
	
	if(file.exists(histFile)){
		
		load(histFile)
		
		r2Hist <- history$r2 # list with R2s of each regression
		prHist <- history$pr # list of parameters used to create X for each regression
		eqHist <- history$eq # equations in human readable format
		ses <- history$ses # session number
		regs <- history$regs # number of regressions run so far
		
		history <- list(pr=prHist, eq=eqHist, r2=r2Hist, ses=ses, regs=regs)

	}else{
		
		history <- paste("There is no file called ", histFile, " for use case ", useCase, ".", sep="")
		
	}

	history
	
}