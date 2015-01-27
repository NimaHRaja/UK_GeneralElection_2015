Get_3Way_Odds <- function(data, major_outcomes, other_outcome){
    
    data_temp <- 
        data[data$Outcome %in% major_outcomes, c("Outcome", "Back", "Lay")]
    
    data_temp[3, c("Back", "Lay")] <-
        1/colSums(1/data[!data$Outcome %in% major_outcomes,c("Back", "Lay")])
    
    data_temp[3, "Outcome"] <- other_outcome
    row.names(data_temp) <- NULL
    
    data_temp
}