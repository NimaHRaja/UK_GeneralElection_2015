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
# setwd("./Codes/")
# source("Get_list_of_Betfair_UKPolitics_Markets.R")
# setwd(root_dir)
```

The output file looks like:

```r
list_of_markets<- 
    read.csv(
        "./raw_data/list_of_Betfair_UKPolitics_Markets.txt",
        header = FALSE)
head(list_of_markets)
```

```
##                                                               V1
## 1 http://www.betfair.com/exchange/politics/market?id=1.114293290
## 2 http://www.betfair.com/exchange/politics/market?id=1.115851511
## 3 http://www.betfair.com/exchange/politics/market?id=1.115852011
## 4 http://www.betfair.com/exchange/politics/market?id=1.115852043
## 5 http://www.betfair.com/exchange/politics/market?id=1.115852058
## 6 http://www.betfair.com/exchange/politics/market?id=1.115852158
```

```r
num_markets <- dim(list_of_markets)[1]
```
There are 689 unique UK-Politics markets on Betfair.

## Getting Odds

A c# project goes through all 689 markets, parses HTMLs, extracts usefull bits, and appends them to the existing *Betfair_UKPolitics_odds.csv* file.

the output looks like:

```r
head(read.table("./raw_data/Betfair_UKPolitics_odds.csv", sep = "\t"))
```

```
##                         V1   V2               V3   V4 V5
## 1 Argyll and Bute - Winner back Liberal Democrat 1.16 20
## 2 Argyll and Bute - Winner back Liberal Democrat 3.50 15
## 3 Argyll and Bute - Winner back     Conservative 3.50 15
## 4 Argyll and Bute - Winner back           Labour 1.56 10
## 5 Argyll and Bute - Winner back           Labour 2.76 45
## 6 Argyll and Bute - Winner back              SNP 1.10 50
##                    V6
## 1 06/01/2015 17:15:42
## 2 06/01/2015 17:15:42
## 3 06/01/2015 17:15:42
## 4 06/01/2015 17:15:42
## 5 06/01/2015 17:15:42
## 6 06/01/2015 17:15:42
```


