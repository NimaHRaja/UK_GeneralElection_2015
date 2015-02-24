# Constituency Markets

major_constituency_markets <- 
    subset(data_matched_constituencies, Matched > 1000, Market)

major_constituency_markets_history_plots_withoutErrorbar <-  
    apply(major_constituency_markets, 1, function(x) 
        Get_Prob_History_Plot(x["Market"],FALSE))

names(major_constituency_markets_history_plots_withoutErrorbar) <- 
    major_constituency_markets$Market

major_constituency_markets_history_plots_withErrorbar <-  
    apply(major_constituency_markets, 1, function(x) 
        Get_Prob_History_Plot(x["Market"],TRUE))

names(major_constituency_markets_history_plots_withErrorbar) <- 
    major_constituency_markets$Market


# Other Markets


major_other_markets <- 
    subset(data_matched_other, Matched > 18000, Market)

major_other_markets_history_plots_withoutErrorbar <-  
    apply(major_other_markets, 1, function(x) 
        Get_Prob_History_Plot(x["Market"],FALSE))


names(major_other_markets_history_plots_withoutErrorbar) <- 
    major_other_markets$Market

major_other_markets_history_plots_withErrorbar <-  
    apply(major_other_markets, 1, function(x) 
        Get_Prob_History_Plot(x["Market"],TRUE))

names(major_other_markets_history_plots_withErrorbar) <- 
    major_other_markets$Market
