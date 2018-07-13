runMCR <- function(useCase, histFile="default", lenHist=NA, maxRegs=1000, maxTime=NA, minAmp=NA, maxBlocks=3, maxPieces=4, ampCoef=100, ampPower=10){
      
      # This function will call MCR to start running.
	
	# useCase: the use case being run; there must be a directory with the same name
	# histFile: file with history of top regressions found so far
	# lenHist: number of top regressions that will be kept for analysis
	# maxRegs: maximum number of regressions run
	# maxTime: maximum execution time in seconds
	# minAmp: minimum amplitude of R2s (difference between highest and lowest R2s in lenHist)
	# maxBlocks: maximum number of blocks in each regression
	# maxPieces: maximum number of pieces in each block
	# ampCoef: amplitude of the coeficient multiplying each block (from -ampCoef to +ampCoef)
	# ampPower: amplitude of elevated power for each piece (from -ampPower to +ampPower)
	
	stTime <- Sys.time()
      
	histFile <- paste(useCase, '/regressions/', histFile, '.RData', sep='')
	
	# if history file exists, it is loaded and its data dumped into variables
      if(file.exists(histFile)){
            
            load(histFile)
            
            # if user didn't set lenHist, we will keep the last one used
      	if(is.na(lenHist)){
                  lenHist <- length(history$r2)
            }
      	
            if(length(history$r2) <= lenHist){
                  r2Hist <- history$r2 # list with R2s of each regression
            }else{
                  r2Hist <- history$r2[1:lenHist] # list with R2s of each regression
            }
            
      	prHist <- history$pr # list of parameters used to create X for each regression
      	ses <- history$ses + 1 # session number
      	regs <- history$regs # number of regressions run so far
            
      # if not, these variables are initialized empty or with default values
      }else{
            
      	# if user didn't set lenHist, we will keep the last one used
      	if(is.na(lenHist)){
                  lenHist <- 10
            }

            r2Hist <- numeric(0) # list with R2s of each regression
            prHist <- list() # list of parameters used to create X for each regression
            ses <- 1 # session number
            regs <- 0 # number of regressions run so far
            
      }
	
	# imports data from Excel and store them in their proper variables
	d = importData(useCase)
	y = d$y
	zs = d$zs
      
      eqHist <- character(0)
      
      # starts to run the regressions
      i <- 1
      # tests whether we will run another regression
      while(keepRunning(maxRegs, i, maxTime, difftime(Sys.time(), stTime, units="secs"), minAmp, findAmplitude(r2Hist, i, lenHist)) == TRUE){
            
            # finds an X value for each observation
      	x <- findX(zs, maxBlocks=maxBlocks, maxPieces=maxPieces, ampCoef=ampCoef, ampPower=ampPower)
      	
      	# runs a regression of X on Y, and calculates its R2
            reg <- lm(y ~ x$values)
            sum <- summary(reg)
            r2 <- sum$r.squared
            
            # if this regression made it to the top list, we are going to record it
            if(length(r2Hist) < lenHist | r2 > r2Hist[lenHist]){
                  
                  regName <- paste('reg', ses, i, sep='-')
                  # regName <- paste('reg-', dC, '-', i, sep='')
                  
                  names(r2) <- regName
                  r2Hist <- append(r2Hist, r2)
                  r2Hist <- r2Hist[order(r2Hist, decreasing=TRUE)]
                  if(length(r2Hist) > lenHist){ # if we have more recorded regressions than lenHist, we will exclude the lowest R2
                        r2Hist <- r2Hist[1:lenHist]
                  }
                  
                  prHist[[regName]] <- x$blocks # records the blocks as parameters
                  
                  # print so the user knows another regression made it to the top
                  print(paste(i, r2Hist[1], r2Hist[1] - r2Hist[length(r2Hist)], sep=" / "))
                  
            }
            
            i <- i + 1
            regs <- regs + 1
            
      }
      
      # now that all regressions were run, we will store the top regressions back in the history file
      eqHist <- writeEquations(r2Hist, prHist) # writes the equation in human readable format
      history <- list(pr=prHist, eq=eqHist, r2=r2Hist, ses=ses, regs=regs)
      save(history, file=histFile)
      
	history

}

findAmplitude <- function(vector, i, lenHist){
	if(i >= lenHist & length(vector) > 1){
		result <- max(vector) - min(vector)
	}else{
		result <- Inf
	}
	result
}