# Gets a URL, Parses the HTML, uses an inner function to iterate over the links 
# inside the HTML and recursively returns all (grand)children of the original url.

List_of_SubMarkets <- function(url, output){
    
    List_of_SubLinks <- function(url){
        html_page <- getURL(url, ssl.verifypeer = FALSE)
        parsed_html <- htmlTreeParse(html_page,useInternal=TRUE)
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