source("Functions/Get_Banzhaf_Power_Index.R")

data <- read.csv("../Raw_Data/UK_Election_2010.csv")
# data <- read.csv("../Raw_Data/ElectoralCalculus_31MAR15.csv")
# data <- read.csv("../Raw_Data/Israel_Election_2015.csv")
# data <- read.csv("../Raw_Data/Israel_Election_2010.csv")


# View(cbind(Get_Banzhaf_Power_Index(data) * 120, t(data)))


