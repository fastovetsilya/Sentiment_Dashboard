library(shiny)
library(shinythemes)
library(shinyFiles)
library(base64enc)
# library(shinyWidgets)
library(markdown)
library(reticulate)

# options(shiny.maxRequestSize = 30*1024^2)

ui <- navbarPage(
  'Shiny app',
  theme = shinytheme('cyborg'),
  tabPanel(
    'Home',
    fluidRow(
      column(4, fileInput('upload', 'Upload image file')),
    ),
    uiOutput('image')
  ),
  tabPanel(
    'About',
    includeMarkdown('about.md')
  )
)

server <- function(input, output, session) {
  
  base64 <- reactive({
    inFile <- input$upload
    if(!is.null(inFile)){
      dataURI(file = inFile$datapath)
    }
  })
  
  output$image <- renderUI({
    if(!is.null(base64())){
      tags$div(
        tags$img(src = base64(), width='100%'),
        style = 'width: 400px;'
      )
    }
  })
  
}

shinyApp(ui, server)

