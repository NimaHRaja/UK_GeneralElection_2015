# Load  Data
source("../General_Functions/Source_All.R")

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



data <- subset(all_odds_data, Market == "UK Seat Totals - UKIP Seats Total")

data <- data[data$date == max(data$date),]
row.names(data) <- NULL

main_outputs <- list("Conservative", "UKIP")
other_outputs <- "OTHER"

labels <- c("CON", "LAB", "NO")
title <- "aef"

data <- 
    Get_3Way_Odds(data,
                  main_outputs,
                  other_outputs)

data <- 
    Get_Convex_Hull(data)


ggtern(data = data, 
       aes(x = Var1, y = Var2, z = Var3)) + 
    geom_polygon(color = "Green")



+
    ggtitle(title) +
    labs(x = labels[1], y = labels[2], z = labels[3]) +
    theme_tern_rgbg(base_size = 18) +
    theme(plot.title = element_text(size = rel(1.5)))





