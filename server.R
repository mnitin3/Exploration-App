options(shiny.maxRequestSize=30*1024^2)

server <- shinyServer(function(input, output, session) {
  # added "session" because updateSelectInput requires it
  
  
  data <- reactive({
    req(input$file1) ## ?req #  require that the input is available
    
    inFile <- input$file1
    
    df <-
      read.csv(
        inFile$datapath,
        header = input$header,
        sep = input$sep,
        quote = input$quote
      )
    
    
    # Update inputs (you could create an observer with both updateSel...)
    # You can also constraint your choices. If you wanted select only numeric
    # variables you could set "choices = sapply(df, is.numeric)"
    # It depends on what do you want to do later on.
    
    updateSelectInput(
      session,
      inputId = 'xcol',
      label = 'X Variable',
      choices = names(df),
      selected = names(df)
    )
    updateSelectInput(
      session,
      inputId = 'ycol',
      label = 'Y Variable',
      choices = names(df),
      selected = names(df)[2]
    )
    
    updateSelectInput(
      session,
      inputId = 'xcol2',
      label = 'X Variable',
      choices = names(df),
      selected = names(df)
    )
    
    return(df)
  })
  
  output$contents <- renderTable({
    data()
  })
  
  output$summarycontents <- renderTable({
    dd <- data()
    summary(dd)
  })
  
  
  output$MyPlot <- renderPlot({
    x <- data()[, c(input$xcol, input$ycol)]
    plot(
      x,
      col = terrain.colors(3),
      main = paste("Distribution of ", input$xcol, " and ", input$ycol)
    )
    
  })
  
  output$MyPlot2 <- renderPlot({
    x <- data()[, c(input$xcol2)]
    plot(x,
         col = terrain.colors(3),
         main = paste("Distribution of ", input$xcol2))
    
  })
})
