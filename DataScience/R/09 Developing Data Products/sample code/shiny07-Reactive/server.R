library(shiny)

shinyServer(
  function(input, output) {
    x <- reactive({as.numeric(input$text1)+100})
    output$text1 <- renderText({ x() })
    output$text2 <- renderText({ x() + as.numeric(input$text2)})
  }
)