# Load  Data, Source Functions, and Libraries

source("../General_Functions/Source_All.R")

Load_Libraries(c("ggplot2", "ggtern", "reshape2", "stringr"))



############################################################################
# Subset Market?

# this_Market <- "UK Seat Totals - UKIP Seats Total"
# this_Market <- "2015 UK General Election - Overall Majority"
 this_Market <- "2015 UK General Election - Most Seats"

data <- subset(all_odds_data, Market == this_Market)

row.names(data) <- NULL


############################################################################
# Market's data -> CSV

# Single_Market_CSV_Output(data, "UKIP_Seats_Market_Ternary.csv")
# Single_Market_CSV_Output(data, "Majority_Market_Ternary.csv")
Single_Market_CSV_Output(data, "Most_Seats_Market_Ternary.csv")




############################################################################
# Class Graph -> PNG

# Single_Market_Classic_Graph_Output(data, "UKIP_Seats_Market.png")
# Single_Market_Classic_Graph_Output(data, "Majority_Market.png")
Single_Market_Classic_Graph_Output(data, "MostSeats_Market.png")


############################################################################
# Ternary Animated -> Gif

# GIF_Output  <- "UKIP_Seats_Prob.gif"
# GIF_Output  <- "Majority_Prob.gif"
GIF_Output  <- "MostSeats_Prob.gif"

number_of_diagrams <- 50
delay <- 20

first_date <-strptime("2014-07-01 00:00:00", "%Y-%m-%d %H:%M:%s")
last_date <-strptime("2015-01-30 00:00:00", "%Y-%m-%d %H:%M:%s")


# main_outputs <- list("None", "One to Five"); 
# other_outputs <- "Over Five";
# labels <- c("None", "One to Five",  "Over 5")



# main_outputs <- list("Conservative Majority", "Labour Majority"); 
# other_outputs <- "No Majority";
# labels <- c("CON", "LAB", "NO")


main_outputs <- list("Conservative", "Labour"); 
other_outputs <- "Other";
labels <- c("CON", "LAB", "NO")




Single_Market_Ternary_Animated_Output(data, 
                                      first_date, 
                                      last_date, 
                                      main_outputs, 
                                      other_outputs, 
                                      GIF_Output, 
                                      labels)

write(as.character(Sys.time()), "time.txt")