Get_ElectoralCalculus_Data <- function(){
    
    options(stringsAsFactors = FALSE)
    
    source("Functions/Load_Libraries.R")
    Load_Libraries(c("XML","reshape2"))
    
    
    electoralcalculus_URL <- "http://www.electoralcalculus.co.uk/homepage.html"
    electoralcalculus_tables <- readHTMLTable(electoralcalculus_URL)
    EC_predictions <- electoralcalculus_tables[[1]][1:8,c(1,4,5)]
    
    
    EC_predictions$Pred_Votes <- 
        as.numeric(sub("%", "", EC_predictions$"Pred Votes"))
    EC_predictions$Pred_Seats <- 
        as.integer(EC_predictions$"Pred Seats")
    
    EC_predictions <- EC_predictions[,c(1,4,5)]
    
    EC_predictions <- melt(EC_predictions, id = "Party")
    
    EC_predictions$Date <- as.character(Sys.time())
    
    
    write.table(EC_predictions, "../EC_predictions.csv", 
                row.names = FALSE, 
                col.names = FALSE, 
                append = TRUE,
                sep = ",")
    
}