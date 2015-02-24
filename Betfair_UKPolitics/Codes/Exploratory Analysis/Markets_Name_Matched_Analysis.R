# Load Libraries
source("../Functions/Load_Libraries.R")
Load_Libraries("ggplot2")
#######################################################################
# Load Data
source("../Functions/Load_Data.R")

#######################################################################
# Load Functions

source("../Functions/Get_Prob_History_Plot.R")
#######################################################################

# length(unique(all_odds_data$Market))
# length(unique(all_odds_data[!is.na(all_odds_data$Matched),"Market"]))

#######################################################################
# Active Markets

# all_markets <- as.data.frame(unique(all_odds_data$Market))
# active_markets <- as.data.frame(
#     unique(all_odds_data[!is.na(all_odds_data$Matched),"Market"]))
# names(all_markets) <- "Market"
# names(active_markets) <- "Market"
# 
# View(
#     all_markets[
#         apply(all_markets, 
#               1, 
#               function(x) !(x %in% (active_markets$Market))),])
# 
#######################################################################
# Constituency and non-constituency Markets

constituency_Markets_test <-
    grepl('Winner',unique(all_odds_data$Market)) & 
    !grepl('2016',unique(all_odds_data$Market))

constituency_Markets <- 
    unique(all_odds_data$Market)[constituency_Markets_test]
other_Markets <-        
    unique(all_odds_data$Market)[!constituency_Markets_test]   

# View(constituency_Markets)
# View(other_Markets)


# ge2010 <- 
#     read.table(
#   "../../../Cluster_Analysis_of_UK_Constituencies_k-means/data/ge_2010.txt",
#         sep = ";", 
#         header = TRUE, 
#         quote = "", # necessary because of family names like "O'Brien"
#         stringsAsFactor = FALSE);
# 
# name_test <- 
#     apply(
#         as.matrix(substr(ge2010$Name, 0,5)), 
#         1, 
#         function(x) sum(grepl(x, constituency_Markets)))

#######################################################################

# test_table <- table(all_odds_data$Market, all_odds_data$Outcome)
# table(as.data.frame(test_table)$Freq)

#######################################################################

# DT_all_odds_data <- data.table(all_odds_data)[,.N,by=list(Market, Outcome)]
# 
# test1_DT <- DT_all_odds_data[,list(min(N),max(N)), by = "Market"]
# View(test1_DT[test1_DT$V1 != test1_DT$V2])

#######################################################################
# Markets with Matched > 0 

data_matched <- 
    as.data.frame(
        tapply(
            all_odds_data$Matched,
            all_odds_data$Market, 
            max, 
            na.rm = TRUE))

names(data_matched) <- "Matched"
data_matched$Market <- row.names(data_matched)
row.names(data_matched) <- NULL


# Constituency Markets

data_matched_constituencies <- 
    subset(
        data_matched , 
        Market %in% constituency_Markets & Matched != 0)

data_matched_constituencies <-
    data_matched_constituencies[
        order(-data_matched_constituencies$Matched),
        c("Market", "Matched")]

row.names(data_matched_constituencies) <- NULL

# Other Markets

data_matched_other <- 
    subset(
        data_matched , 
        !(Market %in% constituency_Markets))

data_matched_other <-
    data_matched_other[
        order(-data_matched_other$Matched),
        c("Market", "Matched")]

row.names(data_matched_other) <- NULL