Get_Convex_Hull <- function(data){
    
    get_possible_points <- function(prob){
        
        
        points <- expand.grid(unlist(prob[1,]), unlist(prob[2,]))
        
        points <- cbind(points, Var3 = (1- rowSums(points)))
        
        points[(points[, 3] < prob[3,1]) & (points[, 3] > prob[3,2]),]
        
    }
    
    prob <- 1/data[,2:3]
    points <- get_possible_points(prob)
    
    
    points2 <- get_possible_points(prob[c(1,3,2),])
    names(points2) <- c("Var1", "Var3", "Var2")
    points <- rbind(points, points2)
    
    
    points3 <- get_possible_points(prob[c(3,2,1),])
    names(points3) <- c("Var3", "Var2", "Var1")
    points <- rbind(points, points3)
    
    points[chull(points),]
    
    
}


