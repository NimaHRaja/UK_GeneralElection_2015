# Load Raw Data 

all_odds_data <- read.table("../data/Betfair_UKPolitics_odds.csv", 
                            sep = "\t"
                            , stringsAsFactor = FALSE)
names(all_odds_data) <- 
    c("Market", "back/lay", "Outcome", "odds", "size", "date_char")


################################################################################
# Clean Market Names

market_names_replacements <- read.table("../data/Market_Names_Replacements.csv", 
                                        sep = "\t", 
                                        stringsAsFactor = FALSE)


paste('Tot_Markets_Before = ', length(unique(all_odds_data$Market)))

for (i in 1:dim(market_names_replacements)[1]){
    all_odds_data$Market <- gsub(market_names_replacements[i,1],
                                 market_names_replacements[i,2],
                                 all_odds_data$Market)
    
    #  print(length(unique(all_odds_data$Market)))
}

paste('Tot_Markets_After = ', length(unique(all_odds_data$Market)))


################################################################################
# Subset data to back and lay

all_back_data <- subset(all_odds_data, all_odds_data$"back/lay" == "back")
all_lay_data <- subset(all_odds_data, all_odds_data$"back/lay" == "lay")
all_matched_data <- subset(all_odds_data, all_odds_data$"back/lay" == "matched")


################################################################################
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


################################################################################
# Merge back, lay and matched

Betfair_UKPolitics_Odds_History <- 
    merge(agg_back, agg_lay, all = TRUE, 
          by = c("Group.1", "Group.2", "Group.3"))

names(Betfair_UKPolitics_Odds_History) <- 
    c("Market", "Outcome", "date_char", "Back", "Lay")


Betfair_UKPolitics_Odds_History <- 
    merge(Betfair_UKPolitics_Odds_History, all_matched_data, 
          all = TRUE, by = c("Market",  "date_char"))

Betfair_UKPolitics_Odds_History <- Betfair_UKPolitics_Odds_History[,c(1:5,7)]
names(Betfair_UKPolitics_Odds_History) <- 
    c("Market", "date_char", "Outcome", "Back", "Lay", "Matched")



# Betfair_UKPolitics_Odds_History <- 
#     Betfair_UKPolitics_Odds_History[
#         !is.na(Betfair_UKPolitics_Odds_History$Outcome),]


################################################################################
# Write to file

write.csv(Betfair_UKPolitics_Odds_History, 
          "../../Betfair_UKPolitics_Odds_History.csv",
          row.names = FALSE)

