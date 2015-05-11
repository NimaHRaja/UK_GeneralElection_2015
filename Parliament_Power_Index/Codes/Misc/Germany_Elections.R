source("../Functions/Get_Banzhaf_Power_Index.R")
source("../Functions/Load_Libraries.R")

Load_Libraries("reshape2")

data <- read.csv("../../raw_data/Historical_data.csv")
data <- data[data$Country == "Germany", 2:4]

conf <- 
    data.frame(
        Color = c("black", "yellow", "red", "green", "darkred", "darkred"),
        Party = c("CDU/CSU","FDP","SPD","GRN","LNK","PDS"),
        Order = c(1,2,3,4,5,6))


for (y in unique(data$Year)){
    
    
    data_ <- data[data$Year == y,]
    
    data_seats <- data_[,3]
    data_seats <- data.frame(t(data_seats))
    names(data_seats) <- data_[,2]
    
    data_BPI <- Get_Banzhaf_Power_Index(data_seats)
    
    
    
    data_BPI[,2] <- data_BPI[,2] * sum(data_[,3])
    
    pie_data <- data_BPI
    pie_data$BPI_Seats <- "BPI_Seats"
    names(pie_data) <- c("Party", "Seats", "Type")
    
    pie_datatemp <- data_[,2:3]
    pie_datatemp$BPI_Seats <- "Real_Seats"
    names(pie_datatemp) <- c("Party", "Seats", "Type")
    
    pie_data <- rbind(pie_datatemp, pie_data)
    
    
    
    
    
    pie_data <- merge(conf, pie_data, by = "Party")
    
    pie_data <- pie_data[order(pie_data$Order),]
    
    Color <- unique(pie_data[order(pie_data$Party),]$Color)
    
    plot <- 
        ggplot(data = pie_data, 
               aes(x = factor(Type), 
                   y = Seats, 
                   fill = Party))
    plot <- plot + geom_bar(stat="identity")
    plot <- plot + coord_polar(theta="y")
    plot <- plot + scale_fill_manual(values = Color)
    
    plot <- plot +labs(y = "Real Seats(Outer) / BPI Seats (Inner)")
    plot <- plot +labs(x = "")
    plot <- plot + ggtitle(y)
    plot <- plot + theme(axis.text=element_blank())
    plot <- plot + theme(axis.ticks = element_blank())
    
    print(paste("plots/",y, ".png", sep = ""))
    png(paste("plots/",y, ".png", sep = ""))
    print(plot)
    dev.off()
}



shell(
    paste("convert -delay",
          120, 
          "Plots/*.png",
          "Germany_BPISeats_animated.gif",
          sep = " "))

