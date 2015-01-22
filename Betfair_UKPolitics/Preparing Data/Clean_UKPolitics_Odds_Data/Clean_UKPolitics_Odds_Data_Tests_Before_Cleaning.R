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