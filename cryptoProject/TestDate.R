#Libraries
library(shiny)
library(shinyWidgets)
library(ggplot2)
library(dplyr)
# library(readxl)
library(scales)
library(ggthemes)
library(plotly)
library(shinythemes)

#Load Data
# myData <- read_excel("C:/Users/Kanew/OneDrive/Desktop/RApp/Unemployment2.xlsx")
myData <- data.frame(
  stringsAsFactors = FALSE,
  Date = c("2010-01-01","2010-02-01",
           "2010-03-01","2010-04-01","2010-05-01","2010-06-01",
           "2010-07-01","2010-08-01","2010-09-01","2010-10-01",
           "2010-11-01","2010-12-01","2011-01-01","2011-02-01",
           "2011-03-01","2011-04-01","2011-05-01","2011-06-01",
           "2011-07-01","2011-08-01"),
  Category = c("National","National",
               "National","National","TestCategory","National","National",
               "National","National","National","National","National",
               "National","National","TestCategory","National","National",
               "National","TestCategory","National"),
  Rate = c(9.8,9.8,9.9,9.9,9.6,9.4,
           9.4,9.5,9.5,9.4,9.8,9.3,9.1,9,9,9.1,9,9.1,9,9)
)


ui <- fluidPage(theme = shinytheme("cerulean"),
                tabsetPanel(
                  
                  tabPanel(
                    "Data Visualization",
                    sidebarLayout(
                      sidebarPanel(
                        sliderInput(
                          inputId = "Date",
                          label = "Dates:",
                          min = min(Bitcoin$Date),
                          max = max(Bitcoin$Date),
                          value = min(Bitcoin$Date),
                          timeFormat = "%Y-%m-%d",
                          step = 1,
                          animate = animationOptions(interval = 300)
                        )
                      ),
                      mainPanel(
                        h1("National Unemployment Rate by Racial/Ethnic Category"),
                        plotlyOutput("plot"), # , height = 'auto', width = 'auto'
                        
                      )
                    )
                  )
                ))

server <- function(input, output) {
  output$plot <- renderPlotly({
  
    
    filteredData <- Bitcoin
    req(nrow(filteredData) > 0)
    
    myGGPlot <- ggplot(filteredData, mapping = aes(x = Date, y = close)) 
      
    
    ggplotly(myGGPlot)
  })
  
  output$myDataTable <- DT::renderDataTable({
    DT::datatable(data)
  })
}

shinyApp(ui = ui, server = server)