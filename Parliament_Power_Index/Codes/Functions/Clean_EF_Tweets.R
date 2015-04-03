Clean_EF_Tweets <- function(EF_tweets) {
    
    # dates and texts
    
    dates <- lapply(EF_tweets, function(x) x$created)
    texts <- lapply(EF_tweets, function(x) x$text)
    
    data <- 
        data.frame(date = as.POSIXct(unlist(dates), origin = "1970-01-01"),
                   text = unlist(texts))
    
    # tweets with forecasts
    
    data <- data[grepl("Latest forecast update",data$text),]
    row.names(data) <- NULL
    
    
    data$text <- gsub("Latest forecast update: ", "",data$text)
    
    data$text <- 
        substr(data$text,
               1,
               regexpr("\\.",data$text) - 1
        )
    
    data
    
}