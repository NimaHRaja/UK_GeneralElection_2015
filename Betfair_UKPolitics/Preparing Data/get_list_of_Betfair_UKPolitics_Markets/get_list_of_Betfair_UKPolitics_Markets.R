List_of_SubMarkets <- function(url, output){
    
    List_of_SubLinks <- function(url){
        parsed_html <- htmlTreeParse(url,useInternal=TRUE)
        xpathSApply(parsed_html,
                    "//ul[@class = 'children']/li/a",
                    xmlGetAttr,"href")       
    }
    
    
    if (!grepl("MENU", url)) {
        
        output <- rbind(output, url)
        
    } else {
        
        type_id <- substr(url,1,1)
        
        if(type_id == "?")
            
            sub_url <- paste(base, url, sep = "/")
        
        else 
            
            sub_url <- url
        
        
        sub_links <- List_of_SubLinks(sub_url)
        
        for (sub_link in sub_links){
            output <- List_of_SubMarkets(sub_link, output)
        }
        
    }
    output
}


source("../../General_Functions/Load_Libraries.R")
Load_Libraries("XML")

base <- "http://www.betfair.com/exchange"
output <- list()



url <-"http://www.betfair.com/exchange/?nodeId=MENU:2707982"
output <- List_of_SubMarkets(url, output)

output <- paste("http://www.betfair.com",unlist(output), sep = "")


write(output, "../data/list_of_Betfair_UKPolitics_Markets.txt")