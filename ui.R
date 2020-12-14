library(shiny)

# Define UI for app that draws a histogram ----
ui <- fluidPage(
    
    shinyjs::useShinyjs(),
    theme = shinytheme("cerulean"),
    #Load global theme (find the corresponding CSS sheet in the .www subdirectory)
    
    #App title 
    titlePanel(
        h1("A random data exploration tool", center = TRUE)
    ),
    br(),
    
    # Sidebar layout with input and output definitions ----
    sidebarLayout(
        
        # Sidebar panel for inputs ----
        sidebarPanel(width = 3,
            
            # Input: Slider for the number of bins ----
            fileInput('file1', 'Choose xlsx file',
                      accept = c(".xlsx")
            ),
            
            #Display size of data
            textOutput(outputId = "data_size"),
            
            br(),
            
            checkboxGroupInput("variables_list", "Variables:",
                         choices = NULL),
        
            
            textOutput(outputId = "vartest")
        ),
        
        mainPanel(width=9,
                  
                  # Create 3 tabs 
                  tabsetPanel(id = 'main_panel',
                              
                             # Plots 
                             tabPanel("Univariate plots",
                                      
                                      br(), 
                                      
                                      checkboxGroupInput("which_univ_plot", "Plots to show:",
                                                         c("Probabiliy density" = "pdf",
                                                           "Cumulative density" = "cdf"),
                                                         selected = NULL, inline = TRUE),
                                      br(),
                                     
                                      # Output: Histogram 
                                      plotOutput(outputId = "pdfPlot"),
                                      plotOutput(outputId = "cdfPlot")
                                     
                              ),
                              
                              #Multivariate plots
                              tabPanel("Multivariate plots", 
                                       
                                       br(),
                                       
                                     checkboxGroupInput("which_multiv_plot", "Plots to show:",
                                                        c("Correlation heatmap" = "corhm",
                                                          "Bivariate scatter" = "scatter"),
                                                         selected = NULL, inline = TRUE),
                                     
                                     br(),
                                     # dropdownButton(
                                     #     tags$h3("List of Input"),
                                     #     selectInput(inputId = 'xcol', label = 'X Variable', choices = names(iris)),
                                     #     selectInput(inputId = 'ycol', label = 'Y Variable', choices = names(iris), selected = names(iris)[[2]]),
                                     #     sliderInput(inputId = 'clusters', label = 'Cluster count', value = 3, min = 1, max = 9),
                                     #     circle = TRUE, status = "danger", icon = icon("gear"), width = "300px",
                                     #     tooltip = tooltipOptions(title = "Click to see inputs !")
                                     # ),
                                     plotOutput(outputId = "heatmap"),
                                     plotOutput(outputId = "bivariate")
                                
                              ),
                              
                              # Scatter matrix 
                             tabPanel("Correlogram",
                                      
                                      br(),
                                      
                                      checkboxGroupInput("display_correlogram", 
                                                         "Show correlogram? It may take a few seconds ...",
                                                         c("Absolutely" = "correlo_yes"),
                                                         selected = NULL, inline = TRUE),
                                      
                                    #Output
                                    plotOutput(outputId = "correlogram")
                             ),
                                    
                              
                              # Table 
                              tabPanel("Summary statistics",
                                    #Output table 
                                    dataTableOutput(outputId = "table")
                              )
        
                )
        )
    )
)
