all_odds_data <- read.table("../Betfair_UKPolitics_Odds_History.csv", 
                            sep = ",", header = TRUE
                            , stringsAsFactor = FALSE)

all_odds_data$date <- 
    strptime(all_odds_data$date_char, "%d/%m/%Y %H:%M:%s")