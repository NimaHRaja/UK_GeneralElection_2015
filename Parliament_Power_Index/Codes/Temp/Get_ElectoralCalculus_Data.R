Get_ElectoralCalculus_Data <- function(){
    
    options(stringsAsFactors = FALSE)
    source("Functions/Load_Libraries.R")
    Load_Libraries(c("XML","reshape2"))
    
    electoralcalculus_URL <- "http://www.electoralcalculus.co.uk/homepage.html"
    electoralcalculus_tables <- readHTMLTable(electoralcalculus_URL)
    date <- as.character(Sys.time())
    
    
    EC_predictions <- electoralcalculus_tables[[1]][1:8,c(1,4,5)]
    EC_predictions$Pred_Votes <- 
        as.numeric(sub("%", "", EC_predictions$"Pred Votes"))
    EC_predictions$Pred_Seats <- 
        as.integer(EC_predictions$"Pred Seats")
    EC_predictions <- EC_predictions[,c(1,4,5)]
    EC_predictions <- melt(EC_predictions, id = "Party")
    EC_predictions$Date <- date
    
    
    EC_outcomes <- electoralcalculus_tables[[2]]
    EC_outcomes[1,1] <- names(EC_outcomes)[1]
    EC_outcomes <- EC_outcomes[EC_outcomes[,1] != "",]
    row.names(EC_outcomes) <- NULL
    names(EC_outcomes) <- c("Outcome", "Probability")
    EC_outcomes$Probability <- as.numeric(sub("%", "", EC_outcomes$Probability))
    EC_outcomes$Date <- date
    
    
    write.table(EC_predictions, "../EC_predictions.csv", 
                row.names = FALSE, 
                col.names = FALSE, 
                append = TRUE,
                sep = ",")
    
    write.table(EC_outcomes, "../EC_outcomes.csv", 
                row.names = FALSE, 
                col.names = FALSE, 
                append = TRUE,
                sep = ",")
    
}