## global.R

# Load libraries
library(shiny)
library(shinyBS)
library(shinythemes)
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


plot_customization_UI <- function(id, 
                                  action_label_1 = NULL,
                                  choice_list_1 = NULL) {
  
  #generate identifier
  ns = NS(id)
  
  
  dropdownButton(
    
    #label the button
    tags$h4("Customize"),
    
    #Select from a list of additional features 
    selectInput(inputId = ns("custom_button"), 
                label = paste(action_label_1), 
                choices = choice_list_1),
    
    circle = TRUE, status = "info", size = "sm",
    icon = icon("gear"), width = "300px",
    
    tooltip = tooltipOptions(title = "Customize the plot")
  )
} 