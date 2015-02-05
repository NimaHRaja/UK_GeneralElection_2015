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
root_dir <- getwd()
setwd("./Codes/")
source("Get_list_of_Betfair_UKPolitics_Markets.R")
```

```
## Warning: package 'XML' was built under R version 3.0.3
```

```
## [1] "Libraries Loaded"
## [1] "/exchange/politics/market?id=1.116751151"
```

```r
setwd(root_dir)
```

The output file looks like:

```r
# list_of_markets<- 
#     read.csv(
#         "./Preparing Data/data/list_of_Betfair_UKPolitics_Markets.txt",
#         header = FALSE)
# num_markets <- dim(list_of_markets)[1]
```



