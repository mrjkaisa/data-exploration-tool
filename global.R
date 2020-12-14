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


source("modules/plot_customization_module.R")
source("modules/plotting_server.R")