# Load  Data
all_odds_data <- read.table("../Betfair_UKPolitics_Odds_History.csv", 
                            sep = ",", header = TRUE
                            , stringsAsFactor = FALSE)

all_odds_data$date <- 
    strptime(all_odds_data$date_char, "%d/%m/%Y %H:%M:%s")

# Find Major Markets

max_matched <- 
    data.frame(
        tapply(
            all_odds_data$Matched, 
            factor(all_odds_data$Market), 
            max, na.rm = TRUE))

max_matched$Market <- row.names(max_matched)
row.names(max_matched) <- NULL
names(max_matched)[1] <- "Matched"

View(max_matched[order(-max_matched$Matched),])



# Find Major constituency Markets

max_matched_constituencies <- 
    max_matched[grepl('Winner', max_matched$Market),]


View(max_matched_constituencies[order(-max_matched_constituencies$Matched),])

View(subset(all_odds_data, Market == "South Thanet - South Thanet - Winner"))
View(subset(all_odds_data, Market == "Brighton Pavilion - Brighton Pavilion - Winner"))
View(subset(all_odds_data, Market == "Hendon - Hendon - Winner"))




# 2015 UK General Election - Most Seats

data_most_seats <- 
    subset(all_odds_data, 
           Market == "2015 UK General Election - Most Seats")


qplot(date, 1/Back, col = Outcome, data = data_most_seats, ylab = "Prob (%)")


# 2015 UK General Election - Overall Majority

data_majority <- 
    subset(all_odds_data, 
           Market == "2015 UK General Election - Overall Majority")


qplot(date, 1/Back, col = Outcome, data = data_majority, ylab = "Prob (%)")



data_majority_latest <- 
    subset(data_majority, date == max(data_majority$date))

data_majority_latest <- 
    data_majority_latest[order(Outcome),]

data_majority_latest[4, c("Back", "Lay")] <- 
    1/colSums(1/data_majority_latest[c(1,4),c("Back", "Lay")])

data_majority_latest <- 
    data_majority_latest[2:4, c("Outcome", "Back", "Lay")]

row.names(data_majority_latest) <- NULL



source("get_convex_hull.R")

tri_graph_data_majority_latest <- get_convex_hull(data_majority_latest)

names(tri_graph_data_majority_latest) <- c("CON", "LAB", "NO")
row.names(tri_graph_data_majority_latest) <- NULL 



#library(ggtern)

ggtern(data = tri_graph_data_majority_latest, 
       aes(x = CON, y = LAB, z = NO)) + 
    geom_point(color = "yellow", size = 6) +
    ggtitle("Prob_Majority") +
    theme_tern_rgbg()



# UK Seat Totals - UKIP Seats Total

data_UKIP_seats <- 
    subset(all_odds_data, 
           Market == "UK Seat Totals - UKIP Seats Total")


qplot(date, 1/Back, col = Outcome, data = data_UKIP_seats, ylab = "Prob (%)")



data_UKIP_seats_latest <- 
    subset(data_UKIP_seats, date_char == max(data_UKIP_seats$date))

data_UKIP_seats_latest <- 
    data_UKIP_seats_latest[, c("Outcome", "Back", "Lay")]

row.names(data_UKIP_seats_latest) <- NULL


source("get_convex_hull.R")

tri_graph_data_UKIP_seats_latest <- get_convex_hull(data_UKIP_seats_latest)

names(tri_graph_data_UKIP_seats_latest) <- c("OneToFive", "OverFive", "None")
row.names(tri_graph_data_UKIP_seats_latest) <- NULL 





