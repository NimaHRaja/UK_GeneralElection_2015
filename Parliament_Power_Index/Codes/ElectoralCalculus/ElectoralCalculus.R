source("../Functions/Get_ElectoralCalculus_Data.R")
source("../Functions/Load_Libraries.R")
Load_Libraries(c("XML","reshape2"))


EC_data <- Get_ElectoralCalculus_Data()
EC_predictions <- EC_data[[1]]
EC_outcomes <- EC_data[[2]]

write.table(EC_predictions, "../../Data/ElectoralCalculus/EC_predictions.csv", 
            row.names = FALSE, 
            col.names = FALSE, 
            append = TRUE,
            sep = ",")

write.table(EC_outcomes, "../../Data/ElectoralCalculus/EC_outcomes.csv", 
            row.names = FALSE, 
            col.names = FALSE, 
            append = TRUE,
            sep = ",")