# Betfair_UKPolitics_PreparingData

### About

Here I explain how I get (and clean) the data from all Betfair's "UK Politics" Markets, i.e. all the sub-branches of [this page](https://www.betfair.com/exchange/?nodeId=MENU:2707982).

### Getting List of Betfair UK Politics Markets

**Get_list_of_Betfair_UKPolitics_Markets.R** recursively retrieves a list of all the market that [this page](http://www.betfair.com/exchange/?nodeId=MENU:2707982) is a parent or (great)grandparent of.  
As the markets don't appear (or disappear) everyday, I only run the following (commented out) chunk once or twice a week.

```r
# root_dir <- getwd()
# setwd("./Codes/Preparing Data/")
# source("Get_list_of_Betfair_UKPolitics_Markets.R")
# setwd(root_dir)
```

The output file looks like:

```r
head(read.csv("./raw_data/list_of_Betfair_UKPolitics_Markets.txt", 
              header = FALSE))
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

### Getting Odds

A c# project goes through all markets, parses HTMLs, extracts useful bits, and appends them to the existing **Betfair_UKPolitics_odds.csv** file. 
To Create two of the class in this project, I used [Fiddler](http://www.telerik.com/fiddler) and [http://json2csharp.com/](http://json2csharp.com/).

For each outcome of each market, the code returns odds and amount to bet for up to 3 (betfair's limit) values for back and up to 3 values for lay. 
For each Market, the code also returns total matched value, i.e. the sum of all bids and asks that have successfully been matched.

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

### Cleaning Market Names

Some Markets had slightly different names when I started collecting data (e.g. *2015 UK General Election - Overall Majority* used to *Next UK General Election - Overall Majority*) 
**Clean_UKPolitics_Odds_Data_Market_Names_Tests_Before_Cleaning.R** runs some tests to find them.

**Market_Names_Replacements.csv** contains a list of "bad" names (first column) to be replaced by "good" ones (second column). It looks like:


```r
head(read.table("./raw_data/Market_Names_Replacements.csv", sep = "\t"))
```

```
##                                                                 V1
## 1                           Next UK General Election - Most Seats 
## 2                     Next UK General Election - Overall Majority 
## 3                           Next UK General Election - UKIP Seats 
## 4 2015 Prime Minister after Cameron - Prime Minister after Cameron
## 5                            Next UK General Election - Most Seats
## 6                      Next UK General Election - Overall Majority
##                                                            V2
## 1                       Next UK General Election - Most Seats
## 2                 Next UK General Election - Overall Majority
## 3                       Next UK General Election - UKIP Seats
## 4 Prime Minister after Cameron - Prime Minister after Cameron
## 5                       2015 UK General Election - Most Seats
## 6                 2015 UK General Election - Overall Majority
```

**Clean_UKPolitics_Odds_Data.R** reads **Betfair_UKPolitics_odds.csv** and replaces the bad names with the good ones according to **Market_Names_Replacements.csv**


```r
root_dir <- getwd()
setwd("./Codes/Preparing Data/")
source("Clean_UKPolitics_Odds_Data.R")
```

```
## [1] "Tot_Markets_Before =  748"
## [1] "Tot_Markets_After =  690"
```

```r
setwd(root_dir)
```

### Reshaping Data

**Clean_UKPolitics_Odds_Data.R** -for each Market/outcome/time combination- finds the best available odds (both back and lay); and saves them (and other relevenat information) in **Betfair_UKPolitics_Odds_History.csv**.

### Output 

Done! **Betfair_UKPolitics_Odds_History.csv** is good to go. it has 6 columns:

- Market 
- Outcome
- Date_char
- Back
- Lay
- Matched

and looks like


```r
head(read.csv("Betfair_UKPolitics_Odds_History.csv", sep = ","))
```

```
##                                      Market           date_char
## 1 2015 UK General Election - Electoral Bias 14/02/2015 11:55:38
## 2 2015 UK General Election - Electoral Bias 14/02/2015 11:55:38
## 3 2015 UK General Election - Electoral Bias 14/02/2015 11:55:38
## 4 2015 UK General Election - Electoral Bias 14/02/2015 11:55:38
## 5 2015 UK General Election - Electoral Bias 14/02/2015 20:42:21
## 6 2015 UK General Election - Electoral Bias 14/02/2015 20:42:21
##                          Outcome  Back  Lay Matched
## 1 Lab fewer votes Lab more seats  2.46  6.2    1986
## 2 Con fewer votes Con more seats 12.00 60.0    1986
## 3  Lab more votes Lab more seats  3.75  4.4    1986
## 4  Con more votes Con more seats  1.91  2.3    1986
## 5 Con fewer votes Con more seats 12.00 60.0    1996
## 6  Lab more votes Lab more seats  3.80  4.4    1996
```
