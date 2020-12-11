## global.R

# Load libraries
library(shiny)
library(shinyBS)
library(shinyjs)
library(shinyWidgets)

library(dplyr)
library(ggplot2)
library(tidyverse)
library(tidyr)

library(GGally)

library(openxlsx)
library(reshape2)

enableBookmarking(store = "server")


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
