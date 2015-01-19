# Load  Data
all_odds_data <- read.table("../Betfair_UKPolitics_Odds_History.csv", 
                            sep = ",", header = TRUE
                            , stringsAsFactor = FALSE)



major_markets <- 
    unique(all_odds_data[all_odds_data$Matched>10000 & !is.na(all_odds_data$Matched),]$Market)



major_markets_data <- all_odds_data[all_odds_data$Market %in% major_markets,]



uu <- major_markets_data[major_markets_data$Market == "2015 UK General Election - Overall Majority",]

ibrary(ggplot2)
qplot(strptime(uu$date_char, "%d/%m/%Y %H:%M:%s"), 1/uu$Back, col = uu$Outcome)




test_data <- major_markets_data[c(203,201,204,202),3:5]
row.names(test_data) <- NULL

test_data[1,2:3] <- 1/(1/test_data[1,2:3] + 1/test_data[3,2:3])

test_data <- test_data[c(1,2,4),]




get_chull <- function(data){
    
    get_possible_points <- function(prob){
        
        
        points <- expand.grid(unlist(prob[1,]), unlist(prob[2,]))
        
        points <- cbind(points, Var3 = (1- rowSums(points)))
        
        points[(points[, 3] < prob[3,1]) & (points[, 3] > prob[3,2]),]
        
    }
    
    prob <- 1/test_data[,2:3]
    points <- get_possible_points(prob)
    
    
    points2 <- get_possible_points(prob[c(1,3,2),])
    names(points2) <- c("Var1", "Var3", "Var2")
    points <- rbind(points, points2)
    
    
    points3 <- get_possible_points(prob[c(3,2,1),])
    names(points3) <- c("Var3", "Var2", "Var1")
    points <- rbind(points, points3)
    
    
    
    points
    
}




points <- get_chull(test_data)
row.names(points ) <- NULL





















major_markets <- 
    unique(all_odds_data[all_odds_data$Matched>10000 & !is.na(all_odds_data$Matched),]$Market)



major_markets_data <- all_odds_data[all_odds_data$Market %in% major_markets,]



uu <- major_markets_data[major_markets_data$Market == "2015 UK General Election - Overall Majority",]

uu$date <- strptime(uu$date_char, "%d/%m/%Y %H:%M:%s")

library(ggplot2)

ggplot(uu, aes(x = date, y = 100/Back, color = Outcome)) + 
    geom_line() +
    ylab("(implied) probability (%)") +     
    labs(title = "Betfair's (implied) probability of GE15 Outcomes")
    
    
    
    + 
    qplot(, 1/uu$Back, col = uu$Outcome)





