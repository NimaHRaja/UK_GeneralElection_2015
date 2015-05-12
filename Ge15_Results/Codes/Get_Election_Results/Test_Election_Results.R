options(stringsAsFactors = FALSE)

data_SKY <- read.table("../../raw_data/ge2015_election_results.csv", 
                       sep = " ", 
                       header = TRUE)

data_BBC <- read.table("../../raw_data/ge2015_election_results_BBC.csv", 
                       sep = "\t",
                       quote = "",
                       header = TRUE)

####################################################

constituencies_SKY <- 
    data.frame(Constituency = unique(data_SKY$Constituency), Source = "SKY")
constituencies_BBC <- 
    data.frame(Constituency = unique(data_BBC$Constituency), Source = "BBC")
all_constituencies <- 
    merge(constituencies_BBC,constituencies_SKY, by = "Constituency", all = TRUE)
# all_constituencies[
#     is.na(all_constituencies$Source.x) | is.na(all_constituencies$Source.y),]

names_update <- read.table("../../raw_data/Constituency_Names_Replacements.csv", 
                           sep = ",")

data_BBC <- 
    merge(data_BBC, names_update, 
          by.x = "Constituency", 
          by.y = "V2", all.x = TRUE)
data_BBC[!is.na(data_BBC$V1),]$Constituency <- data_BBC[!is.na(data_BBC$V1),]$V1

data_BBC <- data_BBC[,1:4]

####################################################

data <- merge(data_BBC, data_SKY, by = c("Votes", "Constituency"), all = TRUE)

View(data[is.na(data$Party.x) | is.na(data$Party.y),])

# 23 minor differences.