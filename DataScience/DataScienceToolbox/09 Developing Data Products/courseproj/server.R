library(shiny)
library(ggplot2)
library(lubridate)
library(httr)

init_data <- function(){
  if(!exists("datasetOverall")){
    #datasetIXIC <- read.csv("http://www.dropbox.com/s/rqt6gk0vrdylehe/nasdaq.csv?dl=1")
    #response <- GET(url = "https://www.dropbox.com/s/rqt6gk0vrdylehe/nasdaq.csv?dl=1") 
    datasetIXIC <- read.csv("hsi.csv")
    
    datasetIXIC$region <- 'US'
    #datasetHSI <- read.csv("http://www.dropbox.com/s/25joq3q1wf3yunx/hsi.csv?dl=1")
    #response <- GET(url = "https://www.dropbox.com/s/25joq3q1wf3yunx/hsi.csv?dl=1") 
    datasetHSI <- read.csv("nasdaq.csv")
    
    datasetHSI$region <- 'HK'
    datasetOverall <<- rbind(datasetIXIC, datasetHSI)
    datasetOverall$Date <<- as.Date(datasetOverall$Date, format = "%d/%m/%Y")
    currDate <<- as.Date("2015/07/01")
  }
}

shinyServer(
  function(input, output) {
    
    withProgress(message = 'Making plot', value = 0, {
      
      init_data();
      
      dataset <- reactive({
        datasetOverall[datasetOverall$region==input$market & 
                         datasetOverall$Date >= (currDate  %m-% months(as.integer(input$range))), ]
      })
      
      output$plotReturn <- renderPlot({
        
        p <- ggplot(dataset(), aes(DailyReturn)) + geom_histogram()
        print(p)
        
      }, height=300)
      
      output$ReturnMean <- renderText({
        paste("Mean of daily return :", mean((dataset())$DailyReturn, na.rm=TRUE) * 100, "%")
      })
      output$ReturnSD <- renderText({
        paste("Standard deviation of daily return :", sd((dataset())$DailyReturn, na.rm=TRUE) * 100, "%")
      })
      
      output$plotVolume <- renderPlot({
        
        p <- ggplot(dataset(), aes(DailyVolume)) + geom_histogram()
        print(p)
        
      }, height=300)
      
      output$VolumeMean <- renderText({
        paste("Mean of volume :", prettyNum(mean((dataset())$DailyVolume, na.rm=TRUE), big.mark=",",scientific=FALSE))
      })
      output$VolumeSD <- renderText({
        paste("Standard deviation of volume :", prettyNum(sd((dataset())$DailyVolume, na.rm=TRUE), big.mark=",",scientific=FALSE))
      })
      
      output$DateRange <- renderText({
        paste("From ", (currDate  %m-% months(as.integer(input$range))) , " to " ,currDate-1)
      })
      
    })
                 
  }
)
