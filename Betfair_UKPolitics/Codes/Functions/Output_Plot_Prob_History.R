# Returns "prob" plot for a given market with/without errorbars

source("../Functions/Load_Libraries.R")
Load_Libraries("ggplot2")

Output_Plot_Prob_History <- function(market, errorbar)
{
    
    data <- all_odds_data[all_odds_data$Market %in% market ,]
    # data <- data[data$Outcome %in% c("Ed Miliband", "David Cameron"),]
    
    data <- data[!is.na(data$Outcome),]
    data$ymax <- 1/data$Back
    data$ymin <- 1/data$Lay
    data[is.na(data$ymax),"ymax"] <- 1 
    data[is.na(data$ymin),"ymin"] <- 0
    data$Prob <- (data$ymax + data$ymin)/2
    
    plot<-
        ggplot(data = data, aes(x = date , y = Prob * 100, colour = Outcome)) + 
        geom_line() +
        facet_grid(. ~ Market) +
        ylab("(implied) probability (%)")
    
    if (errorbar)
        plot <- plot + geom_errorbar(aes(ymin = ymin * 100, ymax = ymax * 100)) 
    
    plot
}