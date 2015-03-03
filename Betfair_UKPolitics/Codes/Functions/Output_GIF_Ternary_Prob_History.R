# Gets instructions for generating an animated GIF
# Creates number_of_diagrams Plots and saves them in /Plots
# Converts the PNG files into an animated GIF
# Deletes all PNG files and /Plots folder


# Load Functions
source("../Functions/Get_Ternary_Diagram.R")
source("../Functions/Get_3Way_Odds.R")

# Load Libraries

source("../Functions/Load_Libraries.R")
Load_Libraries("stringr")

Output_GIF_Ternary_Prob_History <- 
    function(
        data,
        number_of_diagrams,
        delay,
        size,
        first_date, 
        last_date, 
        main_outputs, 
        other_outputs, 
        GIF_Output, 
        labels)
        
    {
        
        
        # Create plots
        data_dates <- unique(data$date)
        data_dates <- data_dates[order(data_dates)]
        
        
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
                    strftime(saved_date, "%d %b %y"),
                    size)
            
            png_file <- 
                paste("plots/",
                      str_pad(i, 3, pad = "0"), 
                      ".png", 
                      sep = "")
            
            print(png_file)
            
            png(png_file, width = 800, height = 800)
            
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
        
    }