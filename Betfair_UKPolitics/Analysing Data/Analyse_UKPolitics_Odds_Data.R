# Load  Data
all_odds_data <- read.table("../Betfair_UKPolitics_Odds_History.csv", 
                            sep = ",", header = TRUE
                            , stringsAsFactor = FALSE)


max(all_odds_data$Matched, na.rm = TRUE)

View(all_odds_data[all_odds_data$Matched>100000 & !is.na(all_odds_data$Matched),])




major_markets <- 
    unique(all_odds_data[all_odds_data$Matched>100000 & !is.na(all_odds_data$Matched),]$Market)



major_markets_data <- all_odds_data[all_odds_data$Market %in% major_markets,]

library(ggplot2)

qplot(
    strptime(date_char, "%d/%m/%Y %H:%M:%s"),1/Back,
    data = 
        subset(major_markets_data, 
               Market == "2015 UK General Election - Most Seats")
    , color = Outcome
    )

