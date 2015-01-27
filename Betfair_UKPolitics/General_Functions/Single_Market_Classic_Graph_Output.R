Single_Market_Classic_Graph_Output <- function(data, PNG_Output){
    
    png(PNG_Output, width = 800, height = 400)
    
    print(
        qplot(date, 
              100/Back, 
              data = data, 
              color = Outcome, 
              ylab = "(implied) probability (%)"))
    
    dev.off()
}