library(shiny)
library(tidyverse)

ui <- fluidPage(
  
  # Application title
  titlePanel("Markdown Lists"),
  
  sidebarLayout(
    sidebarPanel(
      textInput("input_text", "What item is on the shelf?", "soda"),
      numericInput("input_num", "How many times should it repeat?", 99)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      htmlOutput("song")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$song <- renderUI({
    req(input$input_text, input$input_num)
    lines <- map(seq(input$input_num, 0),
                 ~ paste("*", .x, "bottles of", input$input_text)) |>
      paste(collapse = "\n")
    
    markdown(c("## Everybody sing!", lines))
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
