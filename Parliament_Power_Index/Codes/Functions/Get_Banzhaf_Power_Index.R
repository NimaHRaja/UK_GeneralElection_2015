Get_Banzhaf_Power_Index <- function(data){
    
    num_parties <- length(data)
    tot_MPs <- sum(data)
    
    all_comb <- expand.grid(rep(list(0:1), num_parties))
    all_comb <- rep(1, 2^num_parties) %*% as.matrix(data)* as.matrix(all_comb)
    names(all_comb) <- names(data)
    
        
    maj_comb <-  all_comb[rowSums(all_comb) > tot_MPs/2,]
    
    coal_size <- rowSums(maj_comb)
    
    BPI <- colSums(t(apply(maj_comb, 1, function(x) (x-sum(x)+tot_MPs/2)>0)))
    BPI/sum(BPI)
        
}