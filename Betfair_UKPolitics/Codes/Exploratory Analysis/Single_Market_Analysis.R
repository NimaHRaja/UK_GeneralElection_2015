# Load Data, Source Functions, and Libraries

source("../Functions/Load_Data.R")
source("../Functions/Output_CSV_Single_Market.R")
source("../Functions/Output_Plot_Prob_History.R")
source("../Functions/Output_GIF_Ternary_Prob_History.R")

# Choose Parameters

output_choice <- 3

parameters <- read.csv("Single_Market_Analysis_Parameters.csv",
                       stringsAsFactors = FALSE)

number_of_diagrams <- parameters[output_choice,15]
delay <- parameters[output_choice,16]

first_date <- parameters[output_choice,17]
last_date <- parameters[output_choice,18]

first_date <-strptime(first_date, "%Y-%m-%d %H:%M:%s")
last_date <-strptime(last_date, "%Y-%m-%d %H:%M:%s")


this_market <- parameters[output_choice,1]

csv_output_file <- parameters[output_choice,2]
png_output_file_1 <- parameters[output_choice,3]
png_output_file_2 <- parameters[output_choice,4]
ternary_snapshot <- parameters[output_choice,5]
gif_output_file <- parameters[output_choice,6]

main_outputs <- list(parameters[output_choice,7],parameters[output_choice,8]); 
other_outputs <- parameters[output_choice,9];
labels <- as.character(parameters[output_choice,10:12])
row.names(labels) <- NULL

gif_dot_size <- parameters[output_choice,13]
png_dot_size <- parameters[output_choice,14]

############################################################################
# Subset Market
data <- subset(all_odds_data, Market == this_market)
row.names(data) <- NULL

# Market's data -> CSV
write.csv(
    Output_CSV_Single_Market(data), 
    row.names = FALSE,
    csv_output_file)

# Classic Graph -> PNG

png(png_output_file_1, width = 800, height = 400)
Output_Plot_Prob_History(this_market,TRUE)
dev.off()

png(png_output_file_2, width = 800, height = 400)
Output_Plot_Prob_History(this_market,FALSE)
dev.off()

# Ternary Animated -> Gif

Output_GIF_Ternary_Prob_History(data, 
                                number_of_diagrams,
                                delay,
                                gif_dot_size,
                                first_date, 
                                last_date, 
                                main_outputs, 
                                other_outputs, 
                                gif_output_file, 
                                labels)

# Ternary Snapshot -> PNG

data <- subset(data, data$date == max(data$date))

data <- Get_3Way_Odds(data,
                      main_outputs,
                      other_outputs)

png(ternary_snapshot, width = 800, height = 400)
Get_Ternary_Diagram (data, labels, this_market, png_dot_size)
dev.off()


# Write meta data


meta <- data.frame(
    time = as.character(Sys.time()),
    number_of_diagrams = number_of_diagrams,
    delay = delay,
    first_date = first_date,
    last_date = last_date)

write.table(meta, "meta.txt", row.names = FALSE)
