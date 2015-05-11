library(XML)

results_URL <- "http://www.bbc.co.uk/news/politics/constituencies"

results_html_tree <- 
    htmlTreeParse(results_URL, useInternalNodes = TRUE)

constituency_links <- 
    xpathSApply(results_html_tree, "//a", xmlGetAttr, 'href')

constituency_links <- 
    unlist(constituency_links)[88:737]


get_a_constitunecy_results <- function(a_constituency_link){
    
    a_constituency_link <- 
        paste("http://www.bbc.co.uk", a_constituency_link, sep = "")
    
    
    results_html_tree <- 
        htmlTreeParse(a_constituency_link, useInternalNodes = TRUE)
    
    party <- 
        xpathSApply(results_html_tree, 
                    "//div[@class='party__name--long']", 
                    xmlValue)
    
    candidate <- 
        xpathSApply(results_html_tree, 
                    "//div[@class='party__result--candidate']", 
                    xmlValue)
    candidate <- 
        gsub(", with candidate ", "", candidate)
    
    
    votes <- 
        xpathSApply(results_html_tree, 
                    "//li[@class='party__result--votes essential']", 
                    xmlValue)
    votes <- 
        gsub(" total votes taken.", "", votes)
    votes <- 
        as.numeric(gsub(",", "", votes))
    
    
    
    share <- 
        xpathSApply(results_html_tree, 
                    "//li[@class='party__result--votesshare essential']", 
                    xmlValue)
    
    share <-
        gsub(" share of the total vote", "", share)
    
    share_change <- 
        xpathSApply(results_html_tree, 
                    "//li[@class='party__result--votesnet essential']", 
                    xmlValue)
    
    share_change <-
        gsub(" change in share of the votes", "", share_change)
    
    constituency <- 
        xpathSApply(results_html_tree, 
                    "//title", 
                    xmlValue)
    
    constituency <- 
        gsub(" parliamentary constituency - Election 2015 - BBC News", "",constituency)
    
    data.frame(Constituency = constituency,
               Party = party, 
               Candidate = candidate,
               Votes = votes,
               Share = share,
               Share_Change = share_change)
}


constituency_results <- lapply(constituency_links,get_a_constitunecy_results)

constituency_results <- Reduce(function(...) merge(..., all=T), constituency_results)

write.table(constituency_results, 
            "../../rad_data/ge2015_election_results.csv", 
            row.names = FALSE)
write(format(Sys.time(), "%Y-%m-%d %X "), "../../raw_data/download_date_BBC.txt")