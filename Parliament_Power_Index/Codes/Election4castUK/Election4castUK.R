source("../Functions/Get_EF_Tweets.R")
source("../Functions/Clean_EF_Tweets.R")
source("../Functions/Convert_ElectionForecastUK_DF.R")
source("../Functions/Get_Banzhaf_Power_Index.R")
source("../Functions/Load_libraries.R")
Load_Libraries("ggplot2")


# Get and Clean @Election4castUK data

EF_tweets <- Get_EF_Tweets()
EF_tweets <- Clean_EF_Tweets(EF_tweets)

write.csv(EF_tweets,"../../Data/Election4castUK/EF_tweets.csv")



# Extract Party-Seats Data
EF_Seats <- apply(
    EF_tweets[1:100,], 1, 
    function(x) Convert_ElectionForecastUK_DF((x["text"])))

output1 <- cbind(EF_Seats[[1]],date = EF_tweets$date[1])

for (i in 2:length(EF_Seats)){ 
    output1 <-rbind(output1, 
                    data.frame(EF_Seats[[i]], 
                               date = EF_tweets$date[i]))   
}

write.csv(EF_tweets,"../../Data/Election4castUK/EF_Seats.csv")



# Calculate BPI

list_output <- 
    lapply(EF_Seats, function(x) 
    {
        data <- data.frame(t(x$Seats))
        names(data) <- x$Party
        data.frame(unclass(Get_Banzhaf_Power_Index(data)))
        
    }
    )


output2 <- cbind(list_output[[1]],date = EF_tweets$date[1])

for (i in 2:length(list_output)){ 
    output2 <-rbind(output2, 
                    data.frame(list_output[[i]], 
                               date = EF_tweets$date[i]))   
}

write.csv(EF_tweets,"../../Data/Election4castUK/EF_BPI.csv")


# Plot: Seats

data_seats <- subset(output1, 
                     output1$Party %in% c("CON","LAB","SNP","LD", "DUP"))
row.names(data_seats) <- NULL

other_Seats <- data.frame(650-tapply(data_seats$Seats, data_seats$date, sum))
other_Seats$date <- row.names(other_Seats) 
names(other_Seats)[1] <- "Seats"
other_Seats$Party <- "OTH"
row.names(other_Seats) <- NULL

data_seats <- rbind(data_seats, other_Seats)

plot1 <- ggplot(data = data_seats, aes(x = date, y = Seats, color = Party)) 
plot1 <- plot1 + geom_line() + geom_point()
plot1 <- plot1 + scale_color_manual (
    values = c("Blue", "Brown", "Red", "Yellow", "Black", "Orange"))
plot1 <- plot1 + 
    ggtitle("Number of Seats vs. time for different parties (data: Election4castUK)")

png("4castSeats_time.png", width = 800, height = 400)
plot1
dev.off()

# Plot: BPI

data_BPI <- subset(output2, 
                   output2$Party %in% c("CON","LAB","SNP","LD", "DUP"))
row.names(data_BPI) <- NULL

other_BPI <- data.frame(1-tapply(data_BPI$BPI, data_BPI$date, sum))
other_BPI$date <- row.names(other_BPI) 
names(other_BPI)[1] <- "BPI"
other_BPI$Party <- "OTH"
row.names(other_BPI) <- NULL

data_BPI <- rbind(data_BPI, other_BPI)

plot2 <- ggplot(data = data_BPI, aes(x = date, y = 650 * BPI, color = Party)) 
plot2 <- plot2 + geom_line() + geom_point()
plot2 <- plot2 + scale_color_manual (
    values = c("Blue", "Brown", "Red", "Yellow", "Black", "Orange"))
plot2 <- plot2 + 
    ggtitle("Effective (using Banzhaf Power Index) Number of Seats vs. time for different parties (data: Election4castUK)")

png("BPISeats_time.png", width = 800, height = 400)
plot2
dev.off()

# Plot: compare
# qq <- 
#     merge(
#         subset(output1, output1$date == max(output1$date)),
#         subset(output2, output2$date == max(output2$date)),
#         by = "Party")
# 
# ggplot(qq, aes(x = Seats, y = BPI * 650, color = Party)) + geom_point(size = 10)


pie_data <- 
    subset(data_seats, data_seats$date == max(data_seats$date))[,1:2]
pie_data$type <- "4cast_Seats"

pie_data_temp <- 
    subset(data_BPI, data_BPI$date == max(data_BPI$date))[,1:2]
pie_data_temp$BPI <- pie_data_temp$BPI * 650
pie_data_temp$type <- "BPI_Seats"
names(pie_data_temp)[2] <- "Seats"

pie_data <- rbind(pie_data, pie_data_temp)
pie_data <- pie_data[c(1,4,5,6,3,2,7,10,11,12,9,8),]

plot3 <- 
    ggplot(data = pie_data, aes(x = factor(type), y = Seats, fill = Party))
plot3 <- plot3 + geom_bar(stat="identity")
plot3 <- plot3 + coord_polar(theta="y")
plot3 <- plot3 + scale_fill_manual(
    values = c("Blue", "Brown", "Red", "Yellow", "Black", "Orange"))
plot3 <- plot3 +labs(y = "4cast Seats(inner) / BPI Seats (Outer)")
plot3 <- plot3 +labs(x = "")
plot3 <- plot3 + ggtitle("03 APR 15")
plot3 <- plot3 + theme( axis.text.y=element_blank())

png("4castSeats_BPISeats_PieChart.png", width = 800, height = 400)
plot3
dev.off()
