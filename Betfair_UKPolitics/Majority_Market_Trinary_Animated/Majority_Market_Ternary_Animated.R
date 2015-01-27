# Load  Data, Source Functions, and Load Libraries

source("../General_Functions/Load_data.R")
source("../General_Functions/Load_Libraries.R")
source("../General_Functions/Get_Convex_Hull.R")
source("../General_Functions/Get_Ternary_Diagram.R")
source("../General_Functions/Get_3Way_Odds.R")
Load_Libraries(c("ggplot2", "ggtern", "reshape2", "stringr"))



##########################################################################
# subset Majority Market


data_majority <- 
    subset(all_odds_data, 
           Market == "2015 UK General Election - Overall Majority")

data_majority <- 
    subset(data_majority, date >= strptime("01/09/2014", "%d/%m/%Y"))

row.names(data_majority) <- NULL

data_majority_dates <- unique(data_majority$date)
data_majority_dates <- data_majority_dates[order(data_majority_dates)]




##########################################################################
# output1 -> subset data

data_majority_outcome <- 
    melt(data_majority, 
         id.vars = c("date_char", "Outcome"), 
         measure.vars = c("Back", "Lay"))

data_majority_outcome$Outcome <- 
    paste(
        data_majority_outcome$Outcome, 
        data_majority_outcome$variable, 
        sep = "_")

data_majority_outcome <- data_majority_outcome[, c(1,2,4)]

data_majority_outcome <- 
    dcast(data_majority_outcome, date_char ~ Outcome)

data_majority_outcome <- 
    data_majority_outcome[
        order(
            strptime(data_majority_outcome$date_char, "%d/%m/%Y %H:%M:%s")),]

row.names(data_majority_outcome) <- NULL

write.csv(data_majority_outcome, "Majority_Market_Trinary.csv")


##########################################################################
# Output2 -> Classic Graph

png("Majority_Market.png", width = 800, height = 400)

qplot(date, 
      100/Back, 
      data = data_majority, 
      color = Outcome, 
      ylab = "(implied) probability (%)")

dev.off()



##########################################################################
# Output3 -> Animated Gif

number_of_diagrams <- 200
delay <- 10

first_date <-strptime("2014-09-02 00:00:00", "%Y-%m-%d %H:%M:%s")
last_date <-strptime("2015-01-30 00:00:00", "%Y-%m-%d %H:%M:%s")

# Create plots

dir.create("Plots")

for (i in 1:number_of_diagrams)
{
    target_date <- 
        difftime(last_date, 
                 first_date, 
                 units = "secs") * i / number_of_diagrams + first_date
    
    saved_date <- 
        max(data_majority_dates[data_majority_dates < target_date])
    
    data_majority_a_date <- data_majority[
        data_majority$date == 
            saved_date,]            
    
    
    data_majority_a_date <- 
        Get_3Way_Odds(data_majority_a_date,
                      list("Conservative Majority", "Labour Majority"),
                      "No Overall Majority")
    
    labels <- c("CON", "LAB", "NO")
    
    ter_graph <- 
        Get_Ternary_Diagram (
            data_majority_a_date, 
            labels, 
            strftime(saved_date, "%d %b"))
    
    
    png(
        paste("plots/",
              str_pad(i, 3, pad = "0"), 
              ".png", 
              sep = ""), 
        width = 640, 
        height = 640)
    
    print(ter_graph)
    
    dev.off()
}


# bind digrams
shell(
    paste("convert -delay",
          delay, 
          "plots/*.png Majority_Prob.gif",
          sep = " "))


unlink("Plots", recursive = TRUE) 
