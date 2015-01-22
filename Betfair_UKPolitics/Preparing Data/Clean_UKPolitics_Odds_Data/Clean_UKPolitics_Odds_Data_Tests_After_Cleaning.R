all_data <- 
    read.csv("../../Betfair_UKPolitics_Odds_History.csv")

#######################################################################

length(unique(all_data$Market))
length(unique(all_data[!is.na(all_data$Matched),"Market"]))

all_markets <- as.data.frame(unique(all_data$Market))
active_markets <- as.data.frame(unique(all_data[!is.na(all_data$Matched),"Market"]))
names(all_markets) <- "Market"
names(active_markets) <- "Market"

View(
    all_markets[
        apply(all_markets, 
              1, 
              function(x) !(x %in% (active_markets$Market))),])


#######################################################################

constituency_Markets_test <-
    grepl('Winner',unique(all_data$Market)) & 
    !grepl('2016',unique(all_data$Market))

constituency_Markets <- unique(all_data$Market)[constituency_Markets_test]

length(constituency_Markets)

View(constituency_Markets)
View(unique(all_data$Market)[!constituency_Markets_test])




# ge2010 <- 
#     read.table("../../../Cluster_Analysis_of_UK_Constituencies_k-means/data/ge_2010.txt", 
#                sep = ";", 
#                header = TRUE, 
#                quote = "", # necessary because of family names like "O'Brien"
#                stringsAsFactor = FALSE);
# 
# name_test <- 
#     apply(
#         as.matrix(substr(ge2010$Name, 0,5)), 
#         1, 
#         function(x) sum(grepl(x, constituency_Markets)))
#     



#######################################################################

test_table <- table(all_data$Market, all_data$Outcome)
table(as.data.frame(test_table)$Freq)

#######################################################################

library(data.table)
DT_all_odds_data <- data.table(all_data)[,.N,by=list(Market, Outcome)]

test1_DT <- DT_all_odds_data[,list(min(N),max(N)), by = "Market"]
View(test1_DT[test1_DT$V1 != test1_DT$V2])



