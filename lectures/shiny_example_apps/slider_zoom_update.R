library(shiny)
library(ggplot2)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("MPG Data Set Zoom"),

    sidebarLayout(
        sidebarPanel(
            ## add four inputs for the minimum and maximum x and y values
            ## make sure to use checking so that users can't exceed these values
          sliderInput("min_x", "Minimum X value", value = min(mpg$cty),
                       min = min(mpg$cty), max = max(mpg$cty)),
          sliderInput("max_x", "Maximum X value", value = max(mpg$cty),
                       min = min(mpg$cty), max = max(mpg$cty)),
          sliderInput("min_y", "Minimum Y value", value = min(mpg$hwy),
                       min = min(mpg$hwy), max = max(mpg$hwy)),
          sliderInput("max_y", "Maximum Y value", value = max(mpg$hwy),
                       min = min(mpg$hwy), max = max(mpg$hwy))
        ),

        mainPanel(
           plotOutput("mpgPlot")
        )
    )
)

server <- function(input, output) {

    output$mpgPlot <- renderPlot({
      req(input$min_x, input$max_x, input$min_y, input$max_y)
      ## update this to use input$min_x, input$max_x, etc after updating the UI
      ggplot(mpg, aes(cty, hwy)) + geom_jitter() +
        xlim(input$min_x,
             input$max_x) +
        ylim(input$min_y,
             input$max_y)
    })
    
    observeEvent(input$min_x, {
      updateSliderInput(inputId = "max_x", min = input$min_x)
    })
    
    observeEvent(input$max_x, {
      updateSliderInput(inputId = "min_x", max = input$max_x)
    })
    
    observeEvent(input$min_y, {
      updateSliderInput(inputId = "max_y", min = input$min_y)
    })
    
    observeEvent(input$max_y, {
      updateSliderInput(inputId = "min_y", max = input$max_y)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
