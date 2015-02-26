# Returns "prob" plot for a given market with/without errorbars

Output_Plot_Prob_History <- function(market, errorbar)
{
    
    data <- all_odds_data[all_odds_data$Market %in% market ,]
    
    data <- data[!is.na(data$Outcome),]
    data$ymax <- 1/data$Back
    data$ymin <- 1/data$Lay
    data[is.na(data$ymax),"ymax"] <- 1 
    data[is.na(data$ymin),"ymin"] <- 0
    data$Prob <- (data$ymax + data$ymin)/2
    
    plot<-
        ggplot(data = data, aes(x = date , y = Prob, colour = Outcome)) + 
        geom_line() +
        facet_grid(. ~ Market)
    
    if (errorbar)
        plot <- plot + geom_errorbar(aes(ymin = ymin, ymax = ymax)) 
    
    plot
}

# 
# Single_Market_Classic_Graph_Output <- function(data, PNG_Output){
#     
#     png(PNG_Output, width = 800, height = 400)
#     
#     print(
#         qplot(date, 
#               100/Back, 
#               data = data, 
#               color = Outcome, 
#               ylab = "(implied) probability (%)"))
#     
#     dev.off()
# }