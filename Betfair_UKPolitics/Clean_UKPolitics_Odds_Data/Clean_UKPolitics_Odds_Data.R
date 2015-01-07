# Load Raw Data
all_odds_data <- read.table("../Betfair_UKPolitics_odds.csv", 
                            sep = "\t"
                            , stringsAsFactor = FALSE)
names(all_odds_data) <- 
    c("Market", "back/lay", "Outcome", "odds", "size", "date_char")


# Subset data to back and lay
all_back_data <- subset(all_odds_data, all_odds_data$"back/lay" == "back")
all_lay_data <- subset(all_odds_data, all_odds_data$"back/lay" == "lay")


# find max (min) avaiable back(lay) odds
agg_back <-
    aggregate(all_back_data$odds, 
              by=list(all_back_data$Market,
                      all_back_data$Outcome,
                      all_back_data$date_char), 
              FUN=max)

agg_lay <-
    aggregate(all_lay_data$odds, 
              by=list(all_lay_data$Market,
                      all_lay_data$Outcome,
                      all_lay_data$date_char), 
              FUN=min)


# Create output

Betfair_UKPolitics_Odds_History <- 
    merge(agg_back, agg_lay, all = TRUE, 
          by = c("Group.1", "Group.2", "Group.3"))

names(Betfair_UKPolitics_Odds_History) <- 
    c("Market", "Outcome", "Date_Char", "Back", "Lay")


# Test Output

test_table <- table(
    Betfair_UKPolitics_Odds_History$Market, 
    Betfair_UKPolitics_Odds_History$Outcome)

table(as.data.frame(test_table)$Freq)

# Output should only consist of 0 and number of times the odds were retrieved.


# Write output



write.csv(Betfair_UKPolitics_Odds_History, 
            "Betfair_UKPolitics_Odds_History.csv",
          row.names = FALSE)



