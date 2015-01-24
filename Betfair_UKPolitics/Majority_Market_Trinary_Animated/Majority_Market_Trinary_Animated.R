# Load  Data

all_odds_data <- read.table("../Betfair_UKPolitics_Odds_History.csv", 
                            sep = ",", header = TRUE
                            , stringsAsFactor = FALSE)

all_odds_data$date <- 
    strptime(all_odds_data$date_char, "%d/%m/%Y %H:%M:%s")


# Libraries and Functions

library(ggplot2)
library(ggtern)
library(reshape2)
source("Functions/Get_Convex_Hull.R")
source("Functions/Get_Ternary_Diagram.R")


# subset Majority Market


data_majority <- 
    subset(all_odds_data, 
           Market == "2015 UK General Election - Overall Majority")

data_majority <- 
    subset(data_majority, date >= strptime("01/09/2014", "%d/%m/%Y"))

row.names(data_majority) <- NULL

data_majority_dates <- unique(data_majority$date)
data_majority_dates <- data_majority_dates[order(data_majority_dates)]


# output -> subset data

data_majority_output <- 
    melt(data_majority, 
         id.vars = c("date_char", "Outcome"), 
         measure.vars = c("Back", "Lay"))

data_majority_output$Outcome <- 
    paste(
        data_majority_output$Outcome, 
        data_majority_output$variable, 
        sep = "_")

data_majority_output <- data_majority_output[, c(1,2,4)]

data_majority_output <- 
    dcast(data_majority_output, date_char ~ Outcome)

data_majority_output <- 
    data_majority_output[
        order(
            strptime(data_majority_output$date_char, "%d/%m/%Y %H:%M:%s")),]

row.names(data_majority_output) <- NULL

write.csv(data_majority_output, "Majority_Market_Trinary.csv")


png("Majority_Market.png", width = 800, height = 400)

qplot(date, 
      100/Back, 
      data = data_majority, 
      color = Outcome, 
      ylab = "(implied) probability (%)")

dev.off()

# Create plots

for(i in seq_along(data_majority_dates))
{
    
    data_majority_latest <- 
        subset(data_majority, date == data_majority_dates[i])
    
    
    data_majority_latest <- 
        data_majority_latest[order(data_majority_latest$Outcome),]
    
    data_majority_latest[4, c("Back", "Lay")] <- 
        1/colSums(1/data_majority_latest[c(1,4),c("Back", "Lay")])
    
    data_majority_latest <- 
        data_majority_latest[2:4, c("Outcome", "Back", "Lay")]
    
    #    row.names(data_majority_latest) <- NULL
    labels <- c("CON", "LAB", "NO")
    
    ter_graph <- 
        Get_Ternary_Diagram (
            data_majority_latest, 
            labels, 
            strftime(data_majority_dates[i], "%d %b"))
    
    
    png(paste("plots/",i, ".png", sep = ""), width = 640, height = 640)
    print(ter_graph)
    dev.off()
}


# bind digrams

delay_scale <- 10 


delay <- 
    ceiling(
        as.numeric(
            data_majority_dates[2]-data_majority_dates[1],"days")*delay_scale)



shell(
    paste("convert -delay",
          delay, 
          "plots/1.png plots/2.png Majority_Prob.gif",
          sep = " "))


for (i in 2:length(data_majority_dates)){
    
    delay <- 
        ceiling(
            as.numeric(
                data_majority_dates[i]-data_majority_dates[i-1],
                "days")*delay_scale)
    
    shell(
        paste("convert -delay ", 
              delay, 
              " Majority_Prob.gif plots/"
              ,i,
              ".png Majority_Prob.gif", 
              sep = ""))  
    
}








# setwd("./Plots")
# sapply(list.files(), file.remove)
# setwd("..")







