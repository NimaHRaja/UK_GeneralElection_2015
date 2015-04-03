source("../Functions/Get_EF_Tweets.R")
source("../Functions/Clean_EF_Tweets.R")
source("../Functions/Convert_ElectionForecastUK_DF.R")
source("../Functions/Get_Banzhaf_Power_Index.R")


EF_tweets <- Get_EF_Tweets()
data <- Clean_EF_Tweets(EF_tweets)

# ouput 1 

xxx <- apply(data[1:100,], 1, function(x) Convert_ElectionForecastUK_DF((x["text"])))

# output 2 

yyy <- 
    lapply(xxx, function(x) 
    {
        data <- data.frame(t(x$Seats))
        names(data) <- x$Party
        data.frame(unclass(Get_Banzhaf_Power_Index(data)))
        
    }
    )

output <- cbind(yyy[[1]],date = data$date[1])

for (i in 2:length(yyy)){ 
    
         
    
output <-rbind(output, data.frame(yyy[[i]], 
date = data$date[i]))   
}
    
library(ggplot2)


ggplot(data = subset(output, output$BPI > 0.05), aes(x = date, y = 650*BPI, color = Party)) + geom_line()
