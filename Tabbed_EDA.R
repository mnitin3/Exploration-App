ui <- shinyUI(fluidPage(titlePanel("Exploratory Data Analysis Tool"),
                        tabsetPanel(
         
## First Tab   - File upload
                                                    
tabPanel("Upload File", titlePanel("Uploading Files"), 
         sidebarLayout(
             sidebarPanel(
                fileInput( 'file1', 'Choose CSV File', accept = c('text/csv', 'text/comma-separated-values,text/plain', '.csv')
                                ),
                                
                                # added interface for uploading data from
                                # http://shiny.rstudio.com/gallery/file-upload.html
                                tags$br(),
                                checkboxInput('header', 'Header', TRUE),
                                radioButtons('sep', 'Separator',
                                             c(
                                               Comma = ',',
                                               Semicolon = ';',
                                               Tab = '\t',
                                               space = ' '
                                             ),
                                             ','),
                                radioButtons(
                                  'quote',
                                  'Quote',
                                  c(
                                    None = '',
                                    'Double Quote' = '"',
                                    'Single Quote' = "'"
                                  ),
                                  '"'
                                )
                                
                              ),
                              mainPanel(tableOutput('contents'))
                            )
                          ),
tabPanel("Data Summary", titlePanel(" Analysing data "), 
        
           mainPanel(tableOutput('summarycontents'))
         ),

tabPanel("Uni-variate Analysis",pageWithSidebar(headerPanel('Uni Variate Analysis'),
                                      sidebarPanel(
                                        # "Empty inputs" - they will be updated after the data is uploaded
                                        selectInput('xcol2', 'X Variable', "")
                                        
                                      ),
                                      mainPanel(plotOutput('MyPlot2'))
)
),
tabPanel("Bi-variate Analysis",pageWithSidebar(headerPanel('My First Plot'),
                                               sidebarPanel(
                                                 # "Empty inputs" - they will be updated after the data is uploaded
                                                 selectInput('xcol', 'X Variable', ""),
                                                 selectInput('ycol', 'Y Variable', "", selected = "")
                                                 
                                               ),
                                               mainPanel(plotOutput('MyPlot'))
)
)
                          
                        )))

