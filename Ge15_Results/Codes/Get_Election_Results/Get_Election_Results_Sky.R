library(XML)

get_a_constitunecy_results <- function(a_constituency_link){
    
    results_html_tree <- 
        htmlTreeParse(a_constituency_link, useInternalNodes = TRUE)
    
    party <- 
        xpathSApply(results_html_tree, 
                    "//span[@class='constituency-candidates__party']", 
                    xmlValue)
    
    candidate <- 
        xpathSApply(results_html_tree, 
                    "//span[@class='constituency-candidates__name']", 
                    xmlValue)
    
    votes <- 
        xpathSApply(results_html_tree, 
                    "//span[@class='constituency-candidates__votes']", 
                    xmlValue)
    votes <- 
        as.numeric(gsub(",", "", votes))
    
    constituency <-
        xpathSApply(results_html_tree, 
                                "//title", 
                                xmlValue)
    
    constituency <-
        gsub("General Election 2015 - ", "", constituency)
   
    turnout <- 
        xpathSApply(results_html_tree, 
                           "//div[@class='hexagon__primary ']", 
                           xmlValue)[2]
    
    print(constituency)
    
    data.frame(Constituency = constituency,
               Party = party, 
               Candidate = candidate,
               Votes = votes,
               Turnout = turnout)
    
}



base_URL <- "http://news.sky.com/election/constituency"

constituency_links <- paste(base_URL, 1:650, sep = "/")













constituency_results <- lapply(constituency_links,get_a_constitunecy_results)

constituency_results <- Reduce(function(...) merge(..., all=T), constituency_results)

write.table(constituency_results, 
            "../../raw_data/ge2015_election_results.csv", 
            row.names = FALSE)

write(format(Sys.time(), "%Y-%m-%d %X "), "../../raw_data/download_date_sky.txt")
