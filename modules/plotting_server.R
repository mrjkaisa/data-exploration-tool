make_gg_server<- function(data) {
  plott <- ggplot(data) +
    theme_classic() +
    theme(legend.position = "bottom", legend.title = element_blank(),
          panel.grid.minor = element_blank(), 
          panel.grid.major = element_blank(),
          panel.background = element_blank(),
          plot.background = element_blank(), 
          legend.background = element_blank()) 
  return(plott)
}