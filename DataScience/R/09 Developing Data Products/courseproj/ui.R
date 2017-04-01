library(shiny)
library(ggplot2)

fluidPage(
  
  titlePanel("Daily return and volume on 2 selected stock markets"),
  
  sidebarPanel(
    selectInput('market', 'Market', c('^IXIC (Nasdaq, US)'='US', '^HSI (Hang Seng, Hong Kong)'='HK')),
    
    radioButtons("range", "Past data range",
                 c("1 Month" = "1",
                    "3 Months" = "3",
                    "6 Months" = "6",
                    "1 Year" = "12",
                    "3 Years" = "36",
                    "5 Years" = "60"
                   )),
    textOutput("DateRange")
  ),
  
  mainPanel(
    
    tabsetPanel(type = "tabs", 
                tabPanel("Plot", 
                    textOutput("ReturnMean"),
                    textOutput("ReturnSD"),
                    plotOutput('plotReturn'),
                    textOutput("VolumeMean"),
                    textOutput("VolumeSD"),
                    plotOutput('plotVolume')
                  ), 
                tabPanel("Summary", includeHTML("documentation.html"))
    )
    
    
    
  )
)