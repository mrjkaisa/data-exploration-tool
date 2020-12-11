server <- function(input, output, session) {
    
    df <- reactive({
        req(input$file1)
        inFile <- input$file1
        read.xlsx(inFile$datapath, sheet = 1)
    })
    

    dfwide <- reactive({
        df() %>% 
            mutate(id_column = 1:n()) %>%
            pivot_longer(cols = names(.)[!grepl("id_column", names(.))])
    }) 
    
    
    observe({
        req(input$file1)
        updateCheckboxGroupInput(session, "variables_list", choices = names(df() %>% as_tibble))
    })
    
    vars_selected <- reactive({
        req(input$file1)
        input$variables_list %>% as.character() 
    })
    
    output$vartest <- renderText({
        paste("# selected variable =", length(vars_selected()))
    })
    
    
    
    #### 2.1 Univariate plots ####
    
    #visualize distributions as density
    output$pdfPlot <- renderPlot({
       if ("pdf" %in% input$which_univ_plot) {
        dfwide() %>% 
            filter(name %in% vars_selected()) %>%
            make_gg_server(.) +
            geom_density(aes(x = value, linetype = name, color = name))
        }
    }, bg = "transparent")
    
    output$cdfPlot <- renderPlot({
        if ("cdf" %in% input$which_univ_plot) {
            dfwide() %>% 
                filter(name %in% vars_selected()) %>%
                make_gg_server(.) +
                stat_ecdf(aes(x = value, linetype = name, color = name))
        }
    }, bg = "transparent")
    
    
    
    #### 2.2 Multivariate plots ####
    
    
    #correlation heatmap
    output$heatmap <- renderPlot({
        if ("corhm" %in% input$which_multiv_plot) {
                df() %>% 
                    select(vars_selected()) %>%
                    cor %>% 
                    melt() %>%
                    as_tibble() %>%
                    make_gg_server(.) +
                    geom_tile(aes(x = Var1, y = Var2, fill = value))
        }
    }, bg = "transparent")
    
    #bivariate scatter plot 
    output$bivariate <- renderPlot({
        if ("scatter" %in% input$which_multiv_plot) {
            
            if (length(vars_selected()) != 2) {
                tibble(x = c(1:5), y = c(1:5)) %>%
                make_gg_server(.) + 
                    annotate("text", x = 2.5, y = 2.5, label = "Please select exactly 2 variables")    
            }
    
            else {
                df() %>% 
                    select(vars_selected()) %>%
                    make_gg_server(.) + 
                    geom_point(aes_string(x = vars_selected()[1], y = vars_selected()[2]))
            }
        }
    }, bg = "transparent")
    
    
    output$correlogram <- renderPlot({
        if ("correlo_yes" %in% input$display_correlogram) {
            
            if (length(vars_selected()) > 10) {
                tibble(x = c(1:5), y = c(1:5)) %>%
                    make_gg_server(.) + 
                    annotate("text", x = 2.5, y = 2.5, label = "A correlogram with >10 variables is ugly")    
            }
            
            else {
                df() %>% 
                    select(vars_selected()) %>%
                    ggpairs(.) + 
                    theme_classic() +
                    theme(legend.position = "bottom", legend.title = element_blank(),
                          panel.grid.minor = element_blank(), 
                          panel.grid.major = element_blank(),
                          panel.background = element_blank(),
                          plot.background = element_blank(), 
                          legend.background = element_blank())
                    }
        }
    }, bg = "transparent")            
                
                
    #table of summary statistics
    output$table <- renderDataTable({
        dfwide() %>% 
            filter(name %in% vars_selected()) %>%
            group_by(name) %>%
            summarize(`Mean` = mean(value), 
                      `St. dev.`  = sd(value),
                      `Median` = median(value),
                      `Min`  = min(value),
                      `Max`  = max(value),
                      `# unique values` = length(unique(value))) %>% ungroup() %>%
            mutate_if(is.numeric, ~round(.x, 2))
    })


    
    
    #display rows and columns    
    output$data_size <-  renderText({ 
        paste("Data has", nrow(df()), "rows in", ncol(df()), "columns")
    })
    
}