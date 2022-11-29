#install.packages("shiny")
#install.packages("dplyr")
#install.packages("ggplot2")

library(shiny)
library(dplyr)
library(ggplot2)

ui <- fluidPage(
  selectInput(inputId = "country", 
              label = "Choose a Country", 
              choices = unique(df$Date)), 
  plotOutput("line")
)

server <- function(input, output) {
  output$line <- renderPlot({
    ggplot(data %>% filter(Country == input$country), 
           aes(year, `Suicides Per Age Group Per 100K Population`, 
               color = age, group = age)) + geom_line()
  })
}
