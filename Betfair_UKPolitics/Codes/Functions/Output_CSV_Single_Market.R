Output_CSV_Single_Market <- function(data){
    
    
    data_outcome <- 
        melt(data, 
             id.vars = c("date_char", "Outcome"), 
             measure.vars = c("Back", "Lay"))
    
    data_outcome$Outcome <- 
        paste(
            data_outcome$Outcome, 
            data_outcome$variable, 
            sep = "_")
    
    data_outcome <- data_outcome[, c(1,2,4)]
    
    data_outcome <- 
        dcast(data_outcome, date_char ~ Outcome)
    
    data_outcome <- 
        data_outcome[
            order(
                strptime(data_outcome$date_char, "%d/%m/%Y %H:%M:%s")),]
    
    row.names(data_outcome) <- NULL
    
    data_outcome
}