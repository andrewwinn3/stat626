library(tidyverse)
library(readr)
library(TSstudio)
library(xts)
library(quantmod)
library(forecast)
library(tis)
library(gridExtra)
library(timeDate)
library(ggplot2)
library(urca)
library(alr3)
library(ggcorrplot)
library(tidyr)
library(dplyr)
library(astsa)

# Some datasets must be trimmed to fit the date range 1978-01-01/2020-04-01
full = data.frame(
  DATE = read.csv(url('https://raw.githubusercontent.com/andrewwinn3/stat626/master/Data/UMCSENT2.csv'))[,1],
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
