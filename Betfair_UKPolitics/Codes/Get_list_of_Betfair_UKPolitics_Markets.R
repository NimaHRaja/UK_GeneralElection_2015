source("../Functions/Load_Libraries.R")
source("../Functions/List_of_SubMarkets.R")

Load_Libraries("XML")



base <- "http://www.betfair.com/exchange"
output <- list()



url <-"http://www.betfair.com/exchange/?nodeId=MENU:2707982"
output <- List_of_SubMarkets(url, output)

output <- paste("http://www.betfair.com",unlist(output), sep = "")


write(output, "../raw_data/list_of_Betfair_UKPolitics_Markets.txt")
