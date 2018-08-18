This repo is host for the Monte Carlo Regression model.

This document provides basic information on how to start running the model. It is currently coded in R and it is assumed basic knowledge on how to use it. Additionally, the package xlsx must be installed.

# FILES

**model.pdf** - Full description of how the model works. If you want to learn about the model, this is where you should start.

**gdp** - Demo use case.

__*.R__ - R files that will run the model. They are well commented and can be used for help.

# HOW TO RUN THE MODEL

1. Download all the contents from the repo. If you don't intend to use the demo use case, you don't need to download the folder gdp and its contents. If you want to use the demo but you do not want to use the regressions in the demo (i.e. you want to start running it from scratch), don't download the regressions folder inside the gdp folder.

2. If you are using your own use case, you need to create a folder with an Excel file called raw-data.xlsx containing your data. The first row should have the variable names; the first column should have your dependent variable; other columns should have you independent variables. Any column placed after a blank column will be ignored.

3. In R, the first thing you need to do is to `source("ini.R")`. Make sure you are in the MCR directory.

4. Next, run `ini()`.

5. You are now ready to start your run with `x <- runMCR("use-case")`. "use-case" will be "gdp" if you are using the demo. If you are not, it is the name of the folder you created in step 2. If you want to change any other setting in the simulation, refer to runMCR.R for help.

6. The model should be running now and once done (with the suggested settings, it should not take long) it will place the results in the x variable declared in step 5.
