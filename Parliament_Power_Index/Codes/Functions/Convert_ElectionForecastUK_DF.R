Convert_ElectionForecastUK_DF <- function(pred){
    options(stringsAsFactors = FALSE)
    
    
    output <- data.frame(toupper(matrix(unlist(strsplit(unlist(strsplit(pred,", "))," ")),ncol=2,byrow = TRUE)))
    
    
    
    
    names(output) <- c("Party", "Seats")
    
    output$Seats <- as.numeric(output$Seats)
    
    if (sum(output$Party == "UKIP") == 0 )
        output <- rbind(output, data.frame(Party = "UKIP", Seats = 1))
    
    if (sum(output$Party == "DUP") == 0 )
        output <- rbind(output, data.frame(Party = "DUP", Seats = 8))
    
    
    output <- rbind(output, data.frame(Party = "SDLP", Seats = 3))
    output <- rbind(output, data.frame(Party = "GRN", Seats = 1))
    output <- rbind(output, data.frame(Party = "SPK", Seats = 1))
    output <- rbind(output, data.frame(Party = "IND", Seats = 1))
    output <- rbind(output, data.frame(Party = "SF", Seats = 5))
    output <- rbind(output, data.frame(Party = "ALI", Seats = 1))
    output <- rbind(output, data.frame(Party = "PC", Seats = 650 - sum(output$Seats)))
    
    output
}