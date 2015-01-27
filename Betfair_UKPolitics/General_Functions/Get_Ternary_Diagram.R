Get_Ternary_Diagram <- function(data, labels, title){
    
    tri_data <- Get_Convex_Hull(data)
    row.names(tri_data) <- NULL 
    
    
    graph <- 
        ggtern(data = tri_data, 
               aes(x = Var1, y = Var2, z = Var3)) + 
        geom_polygon(color = "Green", size = 8) +
        ggtitle(title) +
        labs(x = labels[1], y = labels[2], z = labels[3]) +
        theme_tern_rgbg(base_size = 18) +
        theme(plot.title = element_text(size = rel(1.5)))
    
    graph
}