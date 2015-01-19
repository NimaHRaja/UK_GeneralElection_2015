## Load Raw Data 

all_odds_data <- read.table("../data/Betfair_UKPolitics_odds.csv", 
                            sep = "\t"
                            , stringsAsFactor = FALSE)
names(all_odds_data) <- 
    c("Market", "back/lay", "Outcome", "odds", "size", "date_char")



## Test: Names with extra " "

unique_market_names <- 
    unique(
        all_odds_data[
            !grepl('Winner',all_odds_data$Market),
            "Market"])

unique_market_names[order(unique_market_names)]

unique_market_names[
    substr(
        unique_market_names, 
        nchar(unique_market_names), 
        nchar(unique_market_names)) 
    == " "]


## Test: Replacing Next with 2015

unique_market_names <- 
    unique(
        all_odds_data[
            !grepl('Winner',all_odds_data$Market),
            "Market"])

unique_market_names[order(unique_market_names)]

unique_market_names[grepl("Next", unique_market_names)]
unique_market_names[grepl("2015", unique_market_names)]



## Test: erroneous constituency Markets' names


unique_winner_market_names <- 
    unique(all_odds_data$Market[!grepl('Winner', all_odds_data$Market)])
# 
# 
View(unique_winner_market_names[order(unique_winner_market_names)])
# 
# 
unique_winner_market_names <- 
    unique_winner_market_names[nchar(unique_winner_market_names) %% 2 == 0]

View(
unique_winner_market_names[
    substr(
        unique_winner_market_names,
        0,
        nchar(unique_winner_market_names)/2-3) 
    != 
        substr(
            unique_winner_market_names,
            nchar(unique_winner_market_names)/2 -2,
            nchar(unique_winner_market_names)-6) 
    ])



















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

