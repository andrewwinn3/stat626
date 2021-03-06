library(tidyverse)
library(astsa)
library(forecast)
library(leaps)

# Some datasets must be trimmed to fit the date range 1978-01-01/2020-04-01
full = data.frame(
  DATE = as.Date(read.csv(url('https://raw.githubusercontent.com/andrewwinn3/stat626/master/Data/UMCSENT2.csv'))[,1]),
  UMCSENT = read.csv(url('https://raw.githubusercontent.com/andrewwinn3/stat626/master/Data/UMCSENT2.csv'))[,2],
  UMCSENT.PFC = read.csv(url('https://raw.githubusercontent.com/andrewwinn3/stat626/master/Data/UMCSENT_COMPONENTS.csv'))[,3],
  UMCSENT.PFE = read.csv(url('https://raw.githubusercontent.com/andrewwinn3/stat626/master/Data/UMCSENT_COMPONENTS.csv'))[,4],
  UMCSENT.BC12 = read.csv(url('https://raw.githubusercontent.com/andrewwinn3/stat626/master/Data/UMCSENT_COMPONENTS.csv'))[,5],
  UMCSENT.BC5 = read.csv(url('https://raw.githubusercontent.com/andrewwinn3/stat626/master/Data/UMCSENT_COMPONENTS.csv'))[,6],
  UMCSENT.BC = read.csv(url('https://raw.githubusercontent.com/andrewwinn3/stat626/master/Data/UMCSENT_COMPONENTS.csv'))[,7],
  DGS1 = read.csv(url('https://raw.githubusercontent.com/andrewwinn3/stat626/master/Data/DGS1_2.csv'))[,2],
  UNRATE = read.csv(url('https://raw.githubusercontent.com/andrewwinn3/stat626/master/Data/UNRATE.csv'))[-509,2],
  WTI = read.csv(url('https://raw.githubusercontent.com/andrewwinn3/stat626/master/Data/WTISPLC.csv'))[-509,2],
  SP = read.csv(url('https://raw.githubusercontent.com/andrewwinn3/stat626/master/Data/SP.csv'))$Adj.Close
)

# Box-cox transformation recommended by auto.arima
full$UMCSENT.stab = c(NA, diff(BoxCox(full$UMCSENT, 2)))

# All DGS1 series are being left in for now, since a satisfactory transformation
#    has not been found.
full$DGS1.log = log(full$DGS1)
full$DGS1.log.diff1 = c(0,diff(full$DGS1.log))
full$DGS1.sqrt = sqrt(full$DGS1)
full$DGS1.23.diff2 = c(0,0,diff((full$DGS1)^(2/3),2))
full$DGS1.log.diff2 = c(0,0,diff(full$DGS1.log, 2))
full$DGS1.diff2 = c(0,0,diff(full$DGS1, 2))
full$DGS1.diff1 = c(0,0, diff(full$DGS1, 2))
full$DGS1.log.diff3 = c(0,0,0,diff(full$DGS1.log, 3))

# Stabilized series:
#    series are transformed by B-C procedure and are
#    stationary
full$SP.stab = c(NA, diff(log(full$SP)))
full$UNRATE.stab = c(NA, diff(log(full$UNRATE)))
full$WTI.stab = c(NA, diff(log(full$WTI)))

full$SP.stab.lag1 = lag(full$SP.stab, 1)
full$SP.stab.lag2 = lag(full$SP.stab, 2)
full$SP.stab.lag3 = lag(full$SP.stab, 3)
full$UNRATE.stab.lag1 = lag(full$UNRATE.stab, 1)
full$WTI.stab.lag1 = lag(full$WTI.stab,1)

full.train = full[12:498,]
