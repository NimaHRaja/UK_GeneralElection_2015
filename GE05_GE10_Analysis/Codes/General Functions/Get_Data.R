Get_Data <- function(fileurl, filename) {
    # This function 
    # 1- Creates /data folder.
    # 2- Downloads data from "fileurl" ans saves it in /data folder
    # 3- record download data/time in /data/download_time.txt
    # Note: get_data skips any of or all these steps if it has already been done
    
    
    
    # preparing /data folder
    print("Preparing /data folder ...")
    if (!file.exists("data")) {
        dir.create("data")
        print("/data created")
    } else {
        print("/data exists")
    }
    print("/data is ready.")
    
    
    
    # Downloading the data file
    if (!file.exists(paste("data",filename, sep="/"))) {
        print("Downloading ...")
        download.file(fileurl, destfile = paste("./data",filename, sep="/"))
        download_time <- Sys.time() 
        print(paste("Downloading completed at", download_time))
        
        if(!file.exists("data/download_time.txt"))
            file.create("data/download_time.txt")
        write(as.character(download_time), "data/download_time.txt")
    } else{
        print(paste(filename, " exists", sep = ""))
    }
}
