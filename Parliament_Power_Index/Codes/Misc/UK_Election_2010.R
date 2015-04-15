source("../Functions/Get_Banzhaf_Power_Index.R")
source("../Functions/Load_Libraries.R")

Load_Libraries("reshape2")

data <- read.csv("../../raw_data/Historical_data.csv")
data <- data[data$Country == "UK", 3:4]

data_seats <- data[,2]
data_seats <- data.frame(t(data_seats))
names(data_seats) <- data[,1]

data_BPI <- Get_Banzhaf_Power_Index(data_seats)
data_BPI[,2] <- data_BPI[,2] * 650

data <- merge(data, data_BPI, by = "Party")

data <- data[order(-data$Seats),]

write.csv(data,"../../Sample Outputs/UK_Election_2010.csv", row.names = FALSE)
