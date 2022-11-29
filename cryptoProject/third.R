#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

  navbarPage("Crypto Data",
             tabPanel("Single",
                      sidebarLayout(
                        sidebarPanel(
                          selectInput("cryptoInput", "Select CryptoCurrency",
                                      c("Bitcoin" = "btc",
                                        "Ethereum" = "eth")
                          )
                        ),
                        mainPanel(
                          plotOutput("plot")
                        )
                      )
             ),
             tabPanel("Compare")
  )
  
)

# Define server logic required to draw a histogram
server <- function(input, output) {

  output$plot <- renderPlot({
    plot(cars, type=input$plotType)
  })
  
  output$summary <- renderPrint({
    summary(cars)
  })
  
  output$table <- DT::renderDataTable({
    DT::datatable(cars)
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
