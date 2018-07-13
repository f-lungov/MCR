keepRunning <- function(maxRegs, regs, maxTime, elapsedTime, minAmp, amp){
      
      # This function determines whether MCR should run another regression. If any of the three limits is met, MCR stops.
	
	# maxRegs: the maximum number of regressions that could be run in the session
	# regs: how many regressions have been run in the current session
	# maxTime: the maximum time in seconds the session could last
	# elapsedTime: the elapsed time in the session in seconds
	# minAmp: the minimum difference between the highest and the lowest R2s in the history
	# amp: the current difference between the highest and the lowest R2s in the history
	
      # start by checking if any of the limits were given as numbers above zero
      if((!is.na(maxRegs) & maxRegs > 0) | (!is.na(maxTime) & maxTime > 0) | (!is.na(minAmp) & minAmp > 0)){
            
            result <- TRUE
            
            # of the limits that were set, check if any of them was already met
            
            # if the next regression will increase the total number over the number requested, then no
            if(!is.na(maxRegs) & maxRegs > 0 & maxRegs < regs){
                  result <- FALSE
            }
            
            # if the time elapsed is over the total allowed, then no
            if(!is.na(maxTime) & maxTime > 0 & maxTime < elapsedTime){
                  result <- FALSE
            }
            
            # if the difference between the highest and the lowest R2 in the history is lower then the threshold requested, then no
            if(!is.na(minAmp) & minAmp > 0 & minAmp > amp){
                  result <- FALSE
            }
            
      }else{
            result <- FALSE
      }
      
      result
      
}