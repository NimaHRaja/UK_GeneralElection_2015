# Betfair_UKPolitics_ExploratoryAnalysis



### Number and Type of Markets

- \# Markets = 731
- \# Constituency Markets = 650
- \# Other Markets = 81

### Most active Markets


```r
kable(head(data_matched_other,22), format = "markdown")
```



|Market                                                           | Matched (Â£)|
|:----------------------------------------------------------------|------------:|
|2015 UK General Election - Overall Majority                      |      2965756|
|2015 UK General Election - Most Seats                            |      2193472|
|2015 UK General Election - Next Government                       |       341565|
|2015 UK General Election - Prime Minister After General Election |       203146|
|UK Seat Totals - UKIP Seats Total                                |       192054|
|Prime Minister after Cameron - Prime Minister after Cameron      |        86061|
|Scotland - Most Seats Scotland                                   |        78073|
|2015 UK General Election - Party Leaders                         |        49771|
|UK Seat Totals - UKIP U/O 2.5 Seats                              |        38062|
|UK Seat Totals - UKIP Seats Total 2                              |        30153|
|Next Party Leaders - Next Conservative Leader                    |        26559|
|UK Seat Totals - Conservative Seats Total                        |        19437|
|UK Seat Totals - UKIP U/O 5.5 Seats                              |        17907|
|England - Most Seats England                                     |        17855|
|UK Seat Totals - SNP U/O 35.5 Seats                              |        13404|
|Next Party Leaders - Next Liberal Democrat Leader                |        10251|
|Next Party Leaders - Next Labour Leader                          |         9061|
|UK Seat Totals - Lib Dem Seats Total                             |         8736|
|2015 UK General Election - Electoral Bias                        |         8668|
|2015 UK General Election - Next Government Coalition Parties     |         8085|
|UK Seat Totals - SNP U/O 25.5 Seats                              |         6619|
|UK Seat Totals - SNP U/O 43.5 Seats                              |         5751|

### Most active Constituency Markets


```r
kable(head(data_matched_constituencies,10), format = "markdown")
```



|Market                                         | Matched (Â£)|
|:----------------------------------------------|------------:|
|South Thanet - Winner                          |        44829|
|Brighton Pavilion - Winner                     |         9961|
|Sheffield Hallam - Winner                      |         7218|
|Gordon - Winner                                |         5196|
|Brighton Kemptown - Brighton Kemptown - Winner |         3683|
|Cambourne and Redruth - Winner                 |         3512|
|Rochester and Strood - Winner                  |         2846|
|Castle Point - Castle Point - Winner           |         2463|
|Falkirk - Winner                               |         1881|
|Bristol West - Bristol West - Winner           |         1709|

## Market = Overall Majority

### (implied) Probability vs. date

![](../../Outputs/Majority Market/Majority_Market_Prob_ErrorbarON.png)

### Current Probabilities

![](../../Outputs/Majority Market/Majority_Market_Prob_Ternary_Currnet.PNG)

### (implied) Probability vs. date (Animated GIF)

![](../../Outputs/Majority Market/Majority_Market_Prob_Animated.gif)

## Market = Most Seats

### (implied) Probability vs. date

![](../../Outputs/Most Seats Market/Most_Seats_Market_Prob_ErrorbarON.png)

### Current Probabilities

![](../../Outputs/Most Seats Market/Most_Seats_Market_Prob_Ternary_Currnet.PNG)

### (implied) Probability vs. date (Animated GIF)

![](../../Outputs/Most Seats Market/Most_Seats_Market_Prob_Animated.gif)

## Market = Next Government

### (implied) Probability vs. date

![](../../Outputs/Next Government Market/NextGovernment_Market_Prob_ErrorbarON.png)

### Current Probabilities

![](../../Outputs/Next Government Market/NextGovernment_Market_Prob_Ternary_Currnet.PNG)

### (implied) Probability vs. date (Animated GIF)

![](../../Outputs/Next Government Market/NextGovernment_Market_Prob_Animated.gif)


## Market = Prime Minister After General Election

### (implied) Probability vs. date

![](../../Outputs/PM After Election/PM_AfterElection_Market_Prob_ErrorbarON_Top2.png)

### (implied) Probability vs. date (Animated GIF)

![](../../Outputs/PM After Election/PM_AfterElection_Market_Prob_Animated.gif)


## Market = South Thanet

### (implied) Probability vs. date

![](../../Outputs/South Thanet Market/SouthThanet_Market_Prob_ErrorbarOFF.png)

### Current Probabilities

![](../../Outputs/South Thanet Market/SouthThanet_Market_Prob_Ternary_Currnet.PNG)

### (implied) Probability vs. date (Animated GIF)

![](../../Outputs/Majority Market/Majority_Market_Prob_Animated.gif)

## Market = UKIP Seats

### (implied) Probability vs. date

![](../../Outputs/UKIP Seats Market/UKIP_Seats_Market_Prob_ErrorbarON.png)

### Current Probabilities

![](../../Outputs/UKIP Seats Market/UKIP_Seats_Market_Prob_Ternary_Currnet.PNG)

### (implied) Probability vs. date (Animated GIF)

![](../../Outputs/UKIP Seats Market/UKIP_Seats_Market_Prob_Animated.gif)







