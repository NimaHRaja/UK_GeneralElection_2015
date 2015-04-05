library(reshape2)

data_animated <- data_seats
data_animated$type <- "4cast_Seats"
data_animated$Seats <- as.numeric(data_animated$Seats)

data_animated_temp <- data_BPI
data_animated_temp$BPI <- data_animated_temp$BPI * 650
data_animated_temp$type <- "BPI_Seats"
names(data_animated_temp)[2] <- "Seats"

data_animated[order(data_animated$Party),]

data_animated <- rbind(data_animated, data_animated_temp)

dates <- unique(data_animated$date)
dates <- dates[order(dates)]


    
for (i in 50:100){
data <- subset(data_animated,data_animated$date == dates[i])
data <- data[,c(1,2,4)]
row.names(data) <- NULL
data <- data[order(data$type,data$Party),]
data <- data[c(1,4,2,5,6,3,7,10,8,11,12,9),]

plot3 <- 
    ggplot(data = data, aes(x = factor(type), y = Seats, fill = Party))
plot3 <- plot3 + geom_bar(stat="identity")
plot3 <- plot3 + coord_polar(theta="y")
plot3 <- plot3 + scale_fill_manual(
    values = c("Blue", "Brown", "Red", "Yellow", "Black", "Orange"))
plot3 <- plot3 +labs(y = "4cast Seats(inner) / BPI Seats (Outer)")
plot3 <- plot3 +labs(x = "")
plot3 <- plot3 + ggtitle(strftime(dates[i], "%d %b %y"))
plot3 <- plot3 + theme( axis.text.y=element_blank())
png(paste("data/",as.character(i),".png"))
print(plot3)
dev.off()
}





shell(
    paste("convert -delay",
          25, 
          "data/*.png",
          "test.gif",
          sep = " "))

