# Load  Data, Source Functions, and Libraries

source("../General_Functions/Source_All.R")

Load_Libraries(c("ggplot2", "ggtern", "reshape2", "stringr"))



############################################################################
# Subset Market?

this_Market <- "UK Seat Totals - UKIP Seats Total"

data <- subset(all_odds_data, Market == this_Market)

row.names(data) <- NULL


############################################################################
# Market's data -> CSV

Single_Market_CSV_Output(data, "UKIP_Seats_Market_Ternary.csv")


############################################################################
# Class Graph -> PNG

Single_Market_Classic_Graph_Output(data, "UKIP_Seats_Market.png")


############################################################################
# Ternary Animated -> Gif

GIF_Output  <- "UKIP_Seats_Prob.gif"

number_of_diagrams <- 200
delay <- 5

first_date <-strptime("2014-07-01 00:00:00", "%Y-%m-%d %H:%M:%s")
last_date <-strptime("2015-01-30 00:00:00", "%Y-%m-%d %H:%M:%s")

main_outputs <- list("None", "One to Five")
other_outputs <- "Over Five"

labels <- c("None", "One to Five",  "Over 5")

Single_Market_Ternary_Animated_Output(data, 
                                      first_date, 
                                      last_date, 
                                      main_outputs, 
                                      other_outputs, 
                                      GIF_Output, 
                                      labels)
