# Betfair_UKPolitics_ExploratoryAnalysis

### About

Some Exploratory Analysis of Betfair_UKPolitics_Markets.


```r
root_dir <- getwd()
setwd("./Codes/Exploratory Analysis/")
source("Markets_Name_Matched_Analysis.R")
```

```
## [1] "Libraries Loaded"
```

```r
source("Markets_History_Graph.R")
setwd(root_dir)
```

### Number and Type of Markets


```
## [1] "# Markets = 690"
```

```
## [1] "# Constituency Markets = 650"
```

```
## [1] "# Other Markets = 40"
```

### Constituency Markets

Lots of Constituency Markets are not active yet. Just 55 (out of 650) have non-zero "Matched" value. Those are:


```r
data_matched_constituencies
```

```
##                                                                                Market
## 1                                                South Thanet - South Thanet - Winner
## 2                                      Brighton Kemptown - Brighton Kemptown - Winner
## 3                                        Sheffield Hallam - Sheffield Hallam - Winner
## 4                                Rochester and Strood - Rochester and Strood - Winner
## 5                                      Brighton Pavilion - Brighton Pavilion - Winner
## 6                                                            Hendon - Hendon - Winner
## 7                                                          Falkirk - Falkirk - Winner
## 8                                                            Gordon - Gordon - Winner
## 9                                                        Thurrock - Thurrock - Winner
## 10                                             Great Grimsby - Great Grimsby - Winner
## 11                                       Sutton and Cheam - Sutton and Cheam - Winner
## 12                                                               Hove - Hove - Winner
## 13                                                           Yeovil - Yeovil - Winner
## 14                                             Bradford East - Bradford East - Winner
## 15                                         Glasgow Central - Glasgow Central - Winner
## 16                                           Great Yarmouth - Great Yarmouth - Winner
## 17                                                         Watford - Watford - Winner
## 18                                                   Eastbourne - Eastbourne - Winner
## 19                                           Stockton South - Stockton South - Winner
## 20                           Holborn and St Pancras - Holborn and St Pancras - Winner
## 21 Inverness Nairn Badenoch Strathspey - Inverness Nairn Badenoch Strathspey - Winner
## 22                                 East Dunbartonshire - East Dunbartonshire - Winner
## 23                             Hampstead and Kilburn - Hampstead and Kilburn - Winner
## 24                                         Argyll and Bute - Argyll and Bute - Winner
## 25                                                               Bath - Bath - Winner
## 26       Cities of London and Westminster - Cities of London and Westminster - Winner
## 27                                   Southampton Itchen - Southampton Itchen - Winner
## 28                                                         Clacton - Clacton - Winner
## 29                                             Cardiff North - Cardiff North - Winner
## 30                                               Glasgow East - Glasgow East - Winner
## 31                                       Portsmouth South - Portsmouth South - Winner
## 32                                                       Solihull - Solihull - Winner
## 33                                   Glasgow North East - Glasgow North East - Winner
## 34                     Mid Dorset and North Poole - Mid Dorset and North Poole Winner
## 35                                   Airdrie and Shotts - Airdrie and Shotts - Winner
## 36                                                   Chippenham - Chippenham - Winner
## 37                                               Dudley North - Dudley North - Winner
## 38                                                       Ynys Mon - Ynys Mon - Winner
## 39                                     Vale of Glamorgan - Vale of Glamorgan - Winner
## 40                                               Beaconsfield - Beaconsfield - Winner
## 41                                                     Cambridge - Cambridge - Winner
## 42                                         Brigg and Goole - Brigg and Goole - Winner
## 43                                                       Broxtowe - Broxtowe - Winner
## 44                                             Isle of Wight - Isle of Wight - Winner
## 45                                                       Aberavon - Aberavon - Winner
## 46                                           Aberdeen North - Aberdeen North - Winner
## 47                                               Bristol West - Bristol West - Winner
## 48                             Cambourne and Redruth - Cambourne and Redruth - Winner
## 49                     Cardiff South and Penarth - Cardiff South and Penarth - Winner
## 50                                                   Ceredigion - Ceredigion - Winner
## 51                                                         Cheadle - Cheadle - Winner
## 52                                                         Halifax - Halifax - Winner
## 53                             Heywood and Middleton - Heywood and Middleton - Winner
## 54                                             Norwich South - Norwich South - Winner
## 55                           St Austell and Newquay - St Austell and Newquay - Winner
##    Matched
## 1     5528
## 2     3136
## 3     1842
## 4     1653
## 5     1409
## 6     1000
## 7      672
## 8      568
## 9      327
## 10     250
## 11     170
## 12     160
## 13     138
## 14     110
## 15     102
## 16      94
## 17      86
## 18      81
## 19      80
## 20      76
## 21      70
## 22      62
## 23      61
## 24      52
## 25      48
## 26      48
## 27      43
## 28      40
## 29      32
## 30      30
## 31      30
## 32      26
## 33      22
## 34      22
## 35      20
## 36      20
## 37      20
## 38      20
## 39      10
## 40       8
## 41       8
## 42       6
## 43       6
## 44       5
## 45       4
## 46       4
## 47       4
## 48       4
## 49       4
## 50       4
## 51       4
## 52       4
## 53       4
## 54       4
## 55       4
```

Let's take a look at the history of (implied) probability of various outcomes of these constituencies. Here I use $\frac{1}{2}(\frac{1}{BACK}+\frac{1}{Lay})$ as "Probability".

```r
major_constituency_markets_history_plots_withoutErrorbar
```

```
## $`South Thanet - South Thanet - Winner`
```

![](Betfair_UKPolitics_ExploratoryAnalysis_files/figure-html/unnamed-chunk-4-1.png) 

```
## 
## $`Brighton Kemptown - Brighton Kemptown - Winner`
```

![](Betfair_UKPolitics_ExploratoryAnalysis_files/figure-html/unnamed-chunk-4-2.png) 

```
## 
## $`Sheffield Hallam - Sheffield Hallam - Winner`
```

![](Betfair_UKPolitics_ExploratoryAnalysis_files/figure-html/unnamed-chunk-4-3.png) 

```
## 
## $`Rochester and Strood - Rochester and Strood - Winner`
```

![](Betfair_UKPolitics_ExploratoryAnalysis_files/figure-html/unnamed-chunk-4-4.png) 

```
## 
## $`Brighton Pavilion - Brighton Pavilion - Winner`
```

![](Betfair_UKPolitics_ExploratoryAnalysis_files/figure-html/unnamed-chunk-4-5.png) 

How accurate those numbers are? We also need a measure of "error". Market implies that the probability is something in between $\frac{1}{BACK}$ and $\frac{1}{LAY}$. Let's use those extremes to add errorbars to the graphs:

```r
major_constituency_markets_history_plots_withErrorbar
```

```
## $`South Thanet - South Thanet - Winner`
```

![](Betfair_UKPolitics_ExploratoryAnalysis_files/figure-html/unnamed-chunk-5-1.png) 

```
## 
## $`Brighton Kemptown - Brighton Kemptown - Winner`
```

![](Betfair_UKPolitics_ExploratoryAnalysis_files/figure-html/unnamed-chunk-5-2.png) 

```
## 
## $`Sheffield Hallam - Sheffield Hallam - Winner`
```

![](Betfair_UKPolitics_ExploratoryAnalysis_files/figure-html/unnamed-chunk-5-3.png) 

```
## 
## $`Rochester and Strood - Rochester and Strood - Winner`
```

![](Betfair_UKPolitics_ExploratoryAnalysis_files/figure-html/unnamed-chunk-5-4.png) 

```
## 
## $`Brighton Pavilion - Brighton Pavilion - Winner`
```

![](Betfair_UKPolitics_ExploratoryAnalysis_files/figure-html/unnamed-chunk-5-5.png) 

Huge errorbars. Markets are not liquid enough (yet). The good news is the most important outcomes have smallish errorbars (like UKIP@South_Thanet or LibDem@Sheffield_hallam). Time to switch to ternary graphs?

### Other Markets

Let's take a look at non-constituency markets:


```r
data_matched_other
```

```
##                                                              Market
## 1                       2015 UK General Election - Overall Majority
## 2                             2015 UK General Election - Most Seats
## 3                                 UK Seat Totals - UKIP Seats Total
## 4       Prime Minister after Cameron - Prime Minister after Cameron
## 5                        2015 UK General Election - Next Government
## 6                          2015 UK General Election - Party Leaders
## 7  2015 UK General Election - Prime Minister After General Election
## 8                     Next Party Leaders - Next Conservative Leader
## 9                                    Scotland - Most Seats Scotland
## 10                              UK Seat Totals - UKIP Seats Total 2
## 11                              UK Seat Totals - UKIP U/O 2.5 Seats
## 12                Next Party Leaders - Next Liberal Democrat Leader
## 13                          Next Party Leaders - Next Labour Leader
## 14                              UK Seat Totals - UKIP U/O 5.5 Seats
## 15                              UK Seat Totals - SNP U/O 35.5 Seats
## 16                                     England - Most Seats England
## 17                   London Mayoral Election 2016 - Winner - Winner
## 18                                  Leader Exit Dates - Ed Miliband
## 19                              UK Seat Totals - SNP U/O 11.5 Seats
## 20                             UK Seat Totals - Green U/O 1.5 Seats
## 21                             UK Seat Totals - Lib Dem Seats Total
## 22                              UK Seat Totals - SNP U/O 25.5 Seats
## 23                        2015 UK General Election - Electoral Bias
## 24                        UK Seat Totals - Conservative Seats Total
## 25                       2015 UK General Election - Electoral Bias?
## 26                              UK Seat Totals - Lib Dem Under/Over
## 27                                   Leader Exit Dates - Nick Clegg
## 28                                Leader Exit Dates - David Cameron
## 29                              UK Seat Totals - Labour Seats Total
## 30                             UK Seat Totals - Green U/O 0.5 Seats
## 31           2015 UK General Election - Two General Elections 2015?
## 32                         UK Seat Totals - Conservative Under/Over
## 33                              Cabinet Exit Dates - Prime Minister
## 34                         2015 UK General Election - Voter Turnout
## 35                               UK Seat Totals - Labour Under/Over
## 36                                  Cabinet Exit Dates - Chancellor
## 37                   Northern Ireland - Most Seats Northern Ireland
## 38                                 UK Seat Totals - SNP Seats Total
## 39                                         Wales - Most Seats Wales
## 40                                   Wales - Plaid Cymru Under/Over
##    Matched
## 1  1060583
## 2  1000915
## 3   142433
## 4    73587
## 5    55864
## 6    33999
## 7    29023
## 8    24602
## 9    18560
## 10   14698
## 11   13978
## 12    9357
## 13    8234
## 14    5051
## 15    4933
## 16    4658
## 17    3811
## 18    3465
## 19    3305
## 20    2871
## 21    2800
## 22    2544
## 23    2273
## 24    2128
## 25    1982
## 26    1805
## 27    1283
## 28    1077
## 29     558
## 30     469
## 31     267
## 32     238
## 33     113
## 34     104
## 35      96
## 36      48
## 37      20
## 38      18
## 39      10
## 40       0
```

Let's take a look at the dynamics of the major ones.


```r
major_other_markets_history_plots_withoutErrorbar
```

```
## $`2015 UK General Election - Overall Majority`
```

![](Betfair_UKPolitics_ExploratoryAnalysis_files/figure-html/unnamed-chunk-7-1.png) 

```
## 
## $`2015 UK General Election - Most Seats`
```

![](Betfair_UKPolitics_ExploratoryAnalysis_files/figure-html/unnamed-chunk-7-2.png) 

```
## 
## $`UK Seat Totals - UKIP Seats Total`
```

![](Betfair_UKPolitics_ExploratoryAnalysis_files/figure-html/unnamed-chunk-7-3.png) 

```
## 
## $`Prime Minister after Cameron - Prime Minister after Cameron`
```

![](Betfair_UKPolitics_ExploratoryAnalysis_files/figure-html/unnamed-chunk-7-4.png) 

```
## 
## $`2015 UK General Election - Next Government`
```

![](Betfair_UKPolitics_ExploratoryAnalysis_files/figure-html/unnamed-chunk-7-5.png) 

```
## 
## $`2015 UK General Election - Party Leaders`
```

![](Betfair_UKPolitics_ExploratoryAnalysis_files/figure-html/unnamed-chunk-7-6.png) 

```
## 
## $`2015 UK General Election - Prime Minister After General Election`
```

![](Betfair_UKPolitics_ExploratoryAnalysis_files/figure-html/unnamed-chunk-7-7.png) 

```
## 
## $`Next Party Leaders - Next Conservative Leader`
```

![](Betfair_UKPolitics_ExploratoryAnalysis_files/figure-html/unnamed-chunk-7-8.png) 

```
## 
## $`Scotland - Most Seats Scotland`
```

![](Betfair_UKPolitics_ExploratoryAnalysis_files/figure-html/unnamed-chunk-7-9.png) 

Same graphs with errorbar:


```r
major_other_markets_history_plots_withErrorbar
```

```
## $`2015 UK General Election - Overall Majority`
```

![](Betfair_UKPolitics_ExploratoryAnalysis_files/figure-html/unnamed-chunk-8-1.png) 

```
## 
## $`2015 UK General Election - Most Seats`
```

![](Betfair_UKPolitics_ExploratoryAnalysis_files/figure-html/unnamed-chunk-8-2.png) 

```
## 
## $`UK Seat Totals - UKIP Seats Total`
```

![](Betfair_UKPolitics_ExploratoryAnalysis_files/figure-html/unnamed-chunk-8-3.png) 

```
## 
## $`Prime Minister after Cameron - Prime Minister after Cameron`
```

![](Betfair_UKPolitics_ExploratoryAnalysis_files/figure-html/unnamed-chunk-8-4.png) 

```
## 
## $`2015 UK General Election - Next Government`
```

![](Betfair_UKPolitics_ExploratoryAnalysis_files/figure-html/unnamed-chunk-8-5.png) 

```
## 
## $`2015 UK General Election - Party Leaders`
```

![](Betfair_UKPolitics_ExploratoryAnalysis_files/figure-html/unnamed-chunk-8-6.png) 

```
## 
## $`2015 UK General Election - Prime Minister After General Election`
```

![](Betfair_UKPolitics_ExploratoryAnalysis_files/figure-html/unnamed-chunk-8-7.png) 

```
## 
## $`Next Party Leaders - Next Conservative Leader`
```

![](Betfair_UKPolitics_ExploratoryAnalysis_files/figure-html/unnamed-chunk-8-8.png) 

```
## 
## $`Scotland - Most Seats Scotland`
```

![](Betfair_UKPolitics_ExploratoryAnalysis_files/figure-html/unnamed-chunk-8-9.png) 

# ternary constituencies





