Load_Libraries <- function(list_of_packages){
    
    
    installed_packages <- list_of_packages %in% installed.packages()[,"Package"]
    not_installed_packages <- list_of_packages[!installed_packages]
    
    if(length(not_installed_packages)) 
        install.packages(not_installed_packages)
    
    
    lapply(list_of_packages, library, character.only=T)
    
    print("Libraries Loaded")
    
}