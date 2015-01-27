# Load  Data, Source Functions, and Load Libraries

source("../General_Functions/Load_data.R")
source("../General_Functions/Load_Libraries.R")
source("../General_Functions/Get_Convex_Hull.R")
source("../General_Functions/Get_Ternary_Diagram.R")
source("../General_Functions/Get_3Way_Odds.R")
Load_Libraries(c("ggplot2", "ggtern", "reshape2", "stringr"))


this_Market <- "2015 UK General Election - Overall Majority"
CSV_Output  <- "Majority_Market_Trinary.csv" 
PNG_Output  <- "Majority_Market.png"
GIF_Output  <- "Majority_Prob.gif"


number_of_diagrams <- 5
delay <- 100

first_date <-strptime("2014-09-02 00:00:00", "%Y-%m-%d %H:%M:%s")
last_date <-strptime("2015-01-30 00:00:00", "%Y-%m-%d %H:%M:%s")

main_outputs <- list("Conservative Majority", "Labour Majority")
other_outputs <- "No Overall Majority"

labels <- c("CON", "LAB", "NO")


##########################################################################
# subset Market



data <- 
    subset(all_odds_data, 
           Market == this_Market)

row.names(data) <- NULL

data_dates <- unique(data$date)
data_dates <- data_dates[order(data_dates)]


##########################################################################
# output1 -> subset data

data_outcome <- 
    melt(data, 
         id.vars = c("date_char", "Outcome"), 
         measure.vars = c("Back", "Lay"))

data_outcome$Outcome <- 
    paste(
        data_outcome$Outcome, 
        data_outcome$variable, 
        sep = "_")

data_outcome <- data_outcome[, c(1,2,4)]

data_outcome <- 
    dcast(data_outcome, date_char ~ Outcome)

data_outcome <- 
    data_outcome[
        order(
            strptime(data_outcome$date_char, "%d/%m/%Y %H:%M:%s")),]

row.names(data_outcome) <- NULL

write.csv(data_outcome, CSV_Output)


##########################################################################
# Output2 -> Classic Graph

png(PNG_Output, width = 800, height = 400)

qplot(date, 
      100/Back, 
      data = data, 
      color = Outcome, 
      ylab = "(implied) probability (%)")

dev.off()



##########################################################################
# Output3 -> Animated Gif



# Create plots

dir.create("Plots")

for (i in 1:number_of_diagrams)
{
    target_date <- 
        difftime(last_date, 
                 first_date, 
                 units = "secs") * i / number_of_diagrams + first_date
    
    saved_date <- 
        max(data_dates[data_dates < target_date])
    
    data_a_date <- data[
        data$date == 
            saved_date,]            
    
    
    data_a_date <- 
        Get_3Way_Odds(data_a_date,
                      main_outputs,
                      other_outputs)
    
    
    ter_graph <- 
        Get_Ternary_Diagram (
            data_a_date, 
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
          "plots/*.png",
          GIF_Output,
          sep = " "))


unlink("Plots", recursive = TRUE) 
