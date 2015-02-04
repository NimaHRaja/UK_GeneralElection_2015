# Betfair_UKPolitics

# About

I am interested in *UK Political Betting*. so, I regularly get odds from all Betfair's "UK Politics" Markets, i.e. all the sub-branches of [this page](http://www.betfair.com/exchange/?nodeId=MENU:2707982).

This Project if about Getting, Cleaning, and Exploratory Analysis of those odds.

\newpage  

# Preparing Data

## Getting List of Betfair UK Politics Markets

*Get_list_of_Betfair_UKPolitics_Markets.R* recursively retrives a list of all the market that [this page](http://www.betfair.com/exchange/?nodeId=MENU:2707982) is a parent or grandparent of.

As the markets don't appear (or disappear) everyday, I only run the following (commented out) chunk once or twice a week. 


```r
# root_dir <- getwd()
# setwd("./Preparing Data/Get_list_of_Betfair_UKPolitics_Markets/")
# source("Get_list_of_Betfair_UKPolitics_Markets.R")
# setwd(root_dir)
```

The output file looks like:

```r
list_of_markets<- 
    read.csv(
        "./Preparing Data/data/list_of_Betfair_UKPolitics_Markets.txt",
        header = FALSE)
num_markets <- dim(list_of_markets)[1]
```
Betfair has 689 unique UK-Politics markets.

## Getting Odds

A c# project (/Preparing Data/Betfair_data_parse)goes through all 689 markets, gets 



