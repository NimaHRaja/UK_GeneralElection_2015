Get_Pie_Predicted_BPI_Chart <- function(data_seats,data_BPI, date)
    
{
    pie_data <- 
        data_seats[data_seats$date == date,1:2]
    pie_data$type <- "4cast_Seats"
    
    pie_data_temp <- 
        data_BPI[data_BPI$date == date,1:2]
    pie_data_temp$BPI <- pie_data_temp$BPI * 650
    pie_data_temp$type <- "BPI_Seats"
    names(pie_data_temp)[2] <- "Seats"
    
    pie_data <- rbind(pie_data, pie_data_temp)
    pie_data <- pie_data[with(pie_data, order(type, Party)),]
    pie_data <- pie_data[c(1,4,2,5,6,3,7,10,8,11,12,9),]
    
    
    plot <- 
        ggplot(data = pie_data, aes(x = factor(type), y = Seats, fill = Party))
    plot <- plot + geom_bar(stat="identity")
    plot <- plot + coord_polar(theta="y")
    plot <- plot + scale_fill_manual(
        values = c("Blue", "Brown", "Red", "Yellow", "Black", "Orange"))
    plot <- plot +labs(y = "4cast Seats(inner) / BPI Seats (Outer)")
    plot <- plot +labs(x = "")
    plot <- plot + ggtitle(strftime(date, "%d %b %y"))
    plot <- plot + theme(axis.text=element_blank())
    plot <- plot + theme(axis.ticks = element_blank())
    
    plot
}