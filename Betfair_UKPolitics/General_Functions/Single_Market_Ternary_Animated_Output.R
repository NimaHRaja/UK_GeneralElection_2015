Single_Market_Ternary_Animated_Output <- 
    function(
        data, 
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
                    strftime(saved_date, "%d %b"))
            
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