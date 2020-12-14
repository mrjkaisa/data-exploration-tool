plot_customization_UI <- function(id, 
                                  action_label_1 = NULL,
                                  choice_list_1 = NULL,
                                  allow_multiple = TRUE) {
  
  #generate identifier
  ns = NS(id)
  
  
  dropdownButton(
    
    #inputId = ns,
    
    #label the button
    tags$h4("Customize"),
    
    #Select from a list of additional features 
    selectizeInput(inputId = ns("custom_button"), 
                   label = paste(action_label_1), 
                   choices = choice_list_1,
                   multiple = allow_multiple,
                   selected = NULL),
    
    circle = TRUE, status = "info", size = "sm",
    icon = icon("gear"), width = "300px",
    
    tooltip = tooltipOptions(title = "Customize the plot")
  )
  
  #add output ID to namespace, if output is generated in UI module
  #plotOutput(ns("bivariate"))
} 



plot_customization_server <- function(id) { 

       moduleServer(
        id,
          function(input, output, session) {
              
            trend_type <- reactive({
              input$custom_button %>% as.character
            })
            
            return(trend_type)
          }
       )
}
                                    
                                      
          
