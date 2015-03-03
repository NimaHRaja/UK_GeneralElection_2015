# source("../Functions/Get_Data.R")
# 
# ge_2010_act_url <- 
#     "http://www.electoralcalculus.co.uk/electdata_2010.txt";
# Get_Data(ge_2010_act_url, "ge_2010.txt");
# 
# ge_2005_imp_url <- 
#     "http://www.electoralcalculus.co.uk/electdata_2005nb.txt";
# Get_Data(ge_2005_imp_url, "ge_2005.txt");


ge2010 <- 
    read.table("./data/ge_2010.txt", 
               sep = ";", 
               header = TRUE, 
               quote = "", # necessary because of family names like "O'Brien"
               stringsAsFactor = FALSE);

ge2005 <- 
    read.table("./data/ge_2005.txt", 
               sep = ";", 
               header = TRUE, 
               quote = "", # necessary because of family names like "O'Brien"
               stringsAsFactor = FALSE);



ge2010 <- cbind(ge2010, ge2010[,5]-rowSums(ge2010[,6:11]))
ge2005 <- cbind(ge2005, ge2005[,5]-rowSums(ge2005[,6:11]))


names(ge2010)[12] <- "Abstained"
names(ge2005)[12] <- "Abstained"


ge2010$Winner <- names(ge2010)[apply(ge2010[,6:11],1,which.max)+5]
ge2005$Winner <- names(ge2005)[apply(ge2005[,6:11],1,which.max)+5]


ge2010 <- cbind(ge2010, ge2010[,6:11]/rowSums(ge2010[,6:11])*100)
ge2005 <- cbind(ge2005, ge2005[,6:11]/rowSums(ge2005[,6:11])*100)


names(ge2010)[14:19] <- paste(names(ge2010)[14:19], "share", sep = "_")
names(ge2005)[14:19] <- paste(names(ge2005)[14:19], "share", sep = "_")


names(ge2010)[5:19] <- paste(names(ge2010)[5:19], "10", sep = "_")
names(ge2005)[5:19] <- paste(names(ge2005)[5:19], "05", sep = "_")




ge_data <- merge(ge2005,ge2010, by = c("Name", "Region"), all = TRUE)

# ge2005[ge2005$Name == "Merthyr Tydfil And Rhymney",]
# ge2010[ge2010$Name == "Merthyr Tydfil and Rhymney",]

ge_data[393,5:19] <- ge_data[394,5:19]
ge_data <- ge_data[,c(1:2,5:19,22:36)]
ge_data <- ge_data[c(1:393, 395:651),]

row.names(ge_data) <- NULL


write.csv(ge_data, "../ge05_ge10_data.csv", row.names = FALSE)



