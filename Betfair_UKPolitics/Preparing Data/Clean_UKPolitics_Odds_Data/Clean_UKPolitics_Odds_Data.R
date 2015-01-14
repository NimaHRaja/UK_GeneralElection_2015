# Load Raw Data
all_odds_data <- read.table("../data/Betfair_UKPolitics_odds.csv", 
                            sep = "\t"
                            , stringsAsFactor = FALSE)
names(all_odds_data) <- 
    c("Market", "back/lay", "Outcome", "odds", "size", "date_char")


# Subset data to back and lay
all_back_data <- subset(all_odds_data, all_odds_data$"back/lay" == "back")
all_lay_data <- subset(all_odds_data, all_odds_data$"back/lay" == "lay")
all_matched_data <- subset(all_odds_data, all_odds_data$"back/lay" == "matched")


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
    c("Market", "Outcome", "date_char", "Back", "Lay")


names(Betfair_UKPolitics_Odds_History)
names(all_matched_data)

Betfair_UKPolitics_Odds_History <- 
merge(Betfair_UKPolitics_Odds_History, all_matched_data, 
      all = TRUE, by = c("Market",  "date_char"))

Betfair_UKPolitics_Odds_History <- Betfair_UKPolitics_Odds_History[,c(1:5,7)]
names(Betfair_UKPolitics_Odds_History) <- 
    c("Market", "date_char", "Outcome", "Back", "Lay", "Matched")



# Test Output

# test_table <- table(
#     Betfair_UKPolitics_Odds_History$Market, 
#     Betfair_UKPolitics_Odds_History$Outcome)
# 
# table(as.data.frame(test_table)$Freq)

# Output should only consist of 0 and number of times the odds were retrieved.

# P.S I was wrong. This is not a good test. commented out.




# Load  Data


# library(data.table)
# DT_all_odds_data <- data.table(Betfair_UKPolitics_Odds_History)[,.N,by=list(Market, Outcome)]
# 
# test1_DT <- DT_all_odds_data[,list(min(N),max(N)), by = "Market"]
# 
# 
# View(test1_DT[test1_DT$V1 != test1_DT$V2])
# 
# 
# View(Betfair_UKPolitics_Odds_History[Betfair_UKPolitics_Odds_History$Market == 'Bristol West - Bristol West - Winner',])
# 
# View(Betfair_UKPolitics_Odds_History[rowSums(is.na(Betfair_UKPolitics_Odds_History[,3:5])) == 3,])
# 
# 
# 
# View(Betfair_UKPolitics_Odds_History[is.na(Betfair_UKPolitics_Odds_History$Outcome),])
# 

Betfair_UKPolitics_Odds_History <- 
Betfair_UKPolitics_Odds_History[!is.na(Betfair_UKPolitics_Odds_History$Outcome),]


# Write output




write.csv(Betfair_UKPolitics_Odds_History, 
            "../../Betfair_UKPolitics_Odds_History.csv",
          row.names = FALSE)



