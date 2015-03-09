# library(ggplot2)
data_all <- read.csv("../../ge05_ge10_data.csv", 
                     stringsAsFactor = FALSE)
data10 <- data_all[,18:24]

svd10 <- svd(data10)
svd10$d^2/sum(svd10$d^2)

num_values <- 2

svd10_u <- as.data.frame(svd10$u[,1:num_values])
svd10_d <- as.data.frame(diag(svd10$d[1:num_values]))
svd10_v <- as.data.frame(svd10$v[,1:num_values])

svd10_u <- svd10_u * sqrt(650/2)
svd10_v <- svd10_v * sqrt(7/2)

svd10_all <- rbind(svd10_u, svd10_v)
svd10_all$type <- c(data_all$Winner_10, rep("Party",7))

Parties <- substr(names(data_all)[4:10],0,3)


ggplot(svd10_v, aes(x = V1, y = V2, label = Parties)) + geom_text() 

ggplot(svd10_all, aes(x = V1, y = V2)) + geom_point(aes(color = type))

