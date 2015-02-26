source("../Functions/Get_3Way_Odds.R")
source("../Functions/Get_Convex_Hull.R")
source("../Functions/Get_Ternary_Diagram.R")
source("../Functions/Load_Data.R")



market_name <- "South Thanet"
main_outcomes <- c("UKIP", "Conservative")
other_outcome <- "other"
date <- "04/02/2015 12:37:15"



data_3way <- 
    all_odds_data[all_odds_data$Market == "South Thanet - South Thanet - Winner",]

data_3way <- data_3way[data_3way$date == max(data_3way$date),]
    

data_3way <- 
    Get_3Way_Odds(data_3way,
                  main_outcomes,
                  other_outcome)


ter_graph <- 
    Get_Ternary_Diagram (
        data_3way, 
        c("a","b", "v"), 
        "s")

data_3way <- Get_Convex_Hull(data_3way)
row.names(data_3way) <- NULL 

data_3way[chull(data_3way),]

ggtern(data = data_3way, 
       aes(x = Var1, y = Var2, z = Var3)) + 
    
    geom_polygon(color="green", alpha = 0.01)


+
    ggtitle(title) +
    labs(x = labels[1], y = labels[2], z = labels[3]) +
    theme_tern_rgbg(base_size = 18) +
    theme(plot.title = element_text(size = rel(1.5)))
