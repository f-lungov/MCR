findX <- function(zs, maxBlocks=3, maxPieces=4, ampCoef=10, ampPower=1){
      
      # This function will randomly create an f function, and then use it to calculate X variable out of a set of Z variables.
  	
	# zs: the Z variables
	# maxBlocks: maximum number of blocks in each regression
	# maxPieces: maximum number of pieces in each block
	# ampCoef: amplitude of the coeficient multiplying each block (from -ampCoef to +ampCoef)
	# ampPower: amplitude of elevated power for each piece (from -ampPower to +ampPower)
	
      # x is where all the data will be stored
      x <- list(blocks = list(), values = numeric(0))
      
      # picks the number of blocks
      nmbBlocks <- round(runif(1, 1, maxBlocks))
      
      # for each block...
      for(i in 1:nmbBlocks){
            
            nmbPieces <- round(runif(1, 1, maxPieces)) # picks the number of pieces
            newCoef <- runif(1, -ampCoef, ampCoef) # picks its coeficient
            newVars <- c(sample(colnames(zs), nmbPieces)) # picks the variables for each piece
            newPows <- c(runif(nmbPieces, -ampPower, ampPower)) # picks the power for each piece
            
            # registers the block in x
            x$blocks[[i]] <- list(coef=newCoef, variables=newVars, powers=newPows)
            
      }
      
      # now we will calculate X for each observation, where x = f(Zs) as defined above
      for(i in 1:nrow(zs)){
            
            blocks <- numeric(0)
            nmbBlocks <- length(x$blocks)
            
            # goes through each block
            for(ii in 1:nmbBlocks){
                  
                  pieces <- numeric(0)
                  nmbPieces <- length(x$blocks[[ii]]$variables)
                  
                  # goes through each piece
                  for(iii in 1:nmbPieces){
                  	# applies power to each one
                        pieces[iii] <- (zs[i, x$blocks[[ii]]$variables[iii]]) ^ x$blocks[[ii]]$powers[iii]
                  }
                  
                  # multiplies the coeficient and the values of all the pieces together
                  blocks[ii] <- prod(x$blocks[[ii]]$coef, pieces[1:nmbPieces])
                  
            }
            
            # the X for each observation will be the sum of the values of all of its blocks
            x$values[i] <- sum(blocks[1:nmbBlocks])
      }
      
      x
      
}