library(lattice)
library(latticeExtra)
library(markdown)

  
  shinyUI(fluidPage(
    
  # Application title
  titlePanel("Guessing empirical distributions (univariate)"),
  
  # Sidebar with controls to select the random distribution type
  # and number of observations to generate. Note the use of the
  # br() element to introduce extra vertical spacing
  sidebarLayout(
    sidebarPanel(  
      
      # Counter
      h5(textOutput("hits")),
      htmlOutput("selectUI"),
        selectInput("type", label = "Type of distribution:",
                    choices = c("Frequency distribution", "Relative frequency distribution"),
                                selected = 1),
        
        sliderInput("x.scale", label = "Tip 3d plot:",
                    min = -100, max = 100, value = -84, step = 1),   
        sliderInput("z.scale", label = "Turn 3d plot:",
                    min = -100, max = 100, value = 81, step = 1),
        
      tags$hr(),
        fileInput('file1', 'Use your data (CSV File)',
                  accept=c('text/csv', 
                           'text/comma-separated-values,text/plain', 
                           '.csv')),
        checkboxInput('header', 'Header', TRUE),
        radioButtons('sep', 'Separator',
                     c(Comma=',',
                       Semicolon=';',
                       Tab='\t'),
                     ','),
        radioButtons('quote', 'Quote',
                     c(None='',
                       'Double Quote'='"',
                       'Single Quote'="'"),
                     '"'),
      
      br(), br(),
      
      div("Shiny app by", 
          a(href="http://paulcbauer.eu/",target="_blank", 
            "Paul C. Bauer"),align="right", style = "font-size: 8pt"),
      
      
      div("Shiny/R code:",
          a(href="https://github.com/paulbauer/guessing_distributions/",
            target="_blank","GitHub"),align="right", style = "font-size: 8pt")
      
        
        
      

  ),

 mainPanel(
      tabsetPanel(type = "tabs", 
        tabPanel("3D Plot", plotOutput("plot2")),
        tabPanel("2D Plot", plotOutput("plot")),
        tabPanel("Data", dataTableOutput(outputId="table")),
        tabPanel("Explanation", includeMarkdown("explanation.md")),
        tabPanel("About", includeMarkdown("about.md"))
        

      
      )
    )
  )
))













      



