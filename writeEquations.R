writeEquations <- function(r2Hist, prHist){
      
      # This function will write out the equations in human readable format.
	
	# r2Hist: a vector with all the R2s stored
	# prHist: a list with all the equation parameters of the regressions stored
	
	eqHist <- character(0)
      
	for(i in 1:length(r2Hist)){
		equation <- paste(round(r2Hist[i], 4), "=>")
		for(ii in 1:length(prHist[[names(r2Hist[i])]])){
			if(ii != 1){
				equation <- paste(equation, "+")
			}
                  equation <- paste(equation, "(", round(prHist[[names(r2Hist[i])]][[ii]]$coef, 2))
                  for(iii in 1:length(prHist[[names(r2Hist[i])]][[ii]]$variables)){
                        equation <- paste(equation,
                                          " x ",
                                          prHist[[names(r2Hist[i])]][[ii]]$variables[[iii]],
                                          "^",
                                          round(prHist[[names(r2Hist[i])]][[ii]]$powers[[iii]], 2),
                                          sep=""
                                          )
                  }
                  equation <- paste(equation, ")")
            }
            eqHist <- append(eqHist, equation)
      }
      
      eqHist
      
}