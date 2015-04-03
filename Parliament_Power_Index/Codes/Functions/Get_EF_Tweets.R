Get_EF_Tweets <- function() {
    
    source("../Functions/Load_Libraries.R")
    Load_Libraries("twitteR")
    
    oauth_personal <- read.csv("../../Raw_Data/oauth_personal.csv",
                               stringsAsFactor = FALSE)
    
    key <- 
        oauth_personal$oauth_consumer_key
    key_secret <- 
        oauth_personal$oauth_consumer_secret
    token <- 
        oauth_personal$oauth_token
    token_secret <- 
        oauth_personal$oauth_token_secret
    
    setup_twitter_oauth(key, 
                        key_secret,
                        token,
                        token_secret)
    
    userTimeline("Election4castUK", n = 2000)
    
}