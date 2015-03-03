# Returns a Ternary Plot demonstrating the convex hull of all possible (P1,P2,P3)s

# Load Libraries
source("../Functions/Load_Libraries.R")
Load_Libraries("ggtern")

# Load Functions
source("../Functions/Get_Convex_Hull.R")


Get_Ternary_Diagram <- function(data, labels, title, size){
    
    tri_data <- Get_Convex_Hull(data)
    row.names(tri_data) <- NULL 
    
    
    graph <- 
        ggtern(data = tri_data, 
               aes(x = Var1, y = Var2, z = Var3)) + 
        geom_polygon(color = "Green", size = size) +
        ggtitle(title) +
        labs(x = labels[1], y = labels[2], z = labels[3]) +
        theme_tern_rgbg(base_size = 18) +
        theme(plot.title = element_text(size = rel(1.5)))
    
    graph
}