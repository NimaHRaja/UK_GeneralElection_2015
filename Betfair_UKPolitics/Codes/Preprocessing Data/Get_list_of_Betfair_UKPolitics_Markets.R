# This code gets a full list of all markets that are a sub-branch of url 
# by calling List_of_SubMarkets and writes the outcome into
# list_of_Betfair_UKPolitics_Markets.txt

source("../Functions/Load_Libraries.R")
source("../Functions/Get_List_of_SubMarkets.R")


Load_Libraries(c("XML", "RCurl"))


base <- "https://www.betfair.com/exchange"
output <- list()



url <-"https://www.betfair.com/exchange/?nodeId=MENU:2707982"
output <- Get_List_of_SubMarkets(url, output)
output <- paste("http://www.betfair.com",unlist(output), sep = "")


write(output, "../../raw_data/list_of_Betfair_UKPolitics_Markets.txt")
