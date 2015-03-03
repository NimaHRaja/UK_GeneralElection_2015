# Aggregates Odds for all possible outcomes that are not listed in main_outcomes.

Get_3Way_Odds <- function(data, main_outcomes, other_outcome){
    
    data_temp <- 
        data[data$Outcome %in% main_outcomes, 
                      c("Outcome", "Back", "Lay")]
    
    data_temp[3, c("Back", "Lay")] <-
        1/colSums(1/data[!data$Outcome %in% main_outcomes,
                                  c("Back", "Lay")])
    
    data_temp[3, "Outcome"] <- other_outcome
    row.names(data_temp) <- NULL
    
    data_temp[order(data_temp$Outcome),]
}