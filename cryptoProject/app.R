#install.packages("fpp2")
#install.packages("shiny")
library(shiny)

# Loading Source files
source("data_cleaning.R")
source("ARIMA.R")

# UI
{
  ui <- fluidPage(
    navbarPage("Cryptocurrency Data",
               tabPanel("Single",
                        sidebarLayout(
                          sidebarPanel(
                            #Dropdown menu for selecting cryptocurrency
                            selectInput("select_crypto", "Select Cryptocurrency", choices = c("Bitcoin", "Ethereum", "Doge_Coin")),
                            # Displaying x and y co-ordinates
                            verbatimTextOutput("info"),
                            
                            # Select whether to overlay smooth trend line
                            checkboxInput(inputId = "smoother", label = strong("Overlay smooth trend line"), value = FALSE),
                            
                            # Display only if the smoother is checked
                            conditionalPanel(condition = "input.smoother == true",
                                             sliderInput(inputId = "f", label = "Smoother span:",
                                                         min = 0.01, max = 1, value = 0.67, step = 0.01,
                                                         animate = animationOptions(interval = 100)),
                                             HTML("Higher values give more smoothness.")
                            )
                          ),
                          mainPanel(
                            # Displaying plot graph
                            plotOutput("lineplot", click = "plot_click"),
                            plotOutput("lineplot2", click = "plot_click")
                          )
                        )
               ),
               
               tabPanel("Compare",
                        sidebarPanel(
                          #Dropdown menu for selecting cryptocurrency
                          selectInput("select_crypto1", "Select First Cryptocurrency", choices = c("Bitcoin", "Ethereum", "Doge_Coin")),
                          
                          #Dropdown menu for selecting cryptocurrency
                          selectInput("select_crypto2", "Select Second  Cryptocurrency", choices = c("Ethereum", "Bitcoin", "Doge_Coin")),
                          
                          # Select whether to overlay smooth trend line
                          checkboxInput(inputId = "smoother1", label = strong("Overlay smooth trend line"), value = FALSE),
                          
                          # Display only if the smoother is checked
                          conditionalPanel(condition = "input.smoother1 == true",
                                           sliderInput(inputId = "f1", label = "Smoother span:",
                                                       min = 0.01, max = 1, value = 0.67, step = 0.01,
                                                       animate = animationOptions(interval = 100)),
                                           HTML("Higher values give more smoothness.")
                          )
                        ),
                        mainPanel(
                          # Displaying plot graph
                          plotOutput("lineplot3", click = "plot_click"),
                          plotOutput("lineplot4", click = "plot_click")
                          
                        )
               ),
               
               tabPanel("Prediction",
                        sidebarLayout(
                          
                          sidebarPanel(
                            # Title
                            "Bitcoin Closing Price Prediction",
                            
                            # Slider panel
                            sliderInput(inputId = "h", label = "Quarters to predict",
                                        min = 1, max = 6, value = 6, step = 1)
                          ),
                          
                          # Show a plot of the generated distribution
                          mainPanel(
                            plotOutput("trendPlot")
                          )
                        )
               )
    )
  )
}

# Server
server <- function(input, output) {
  
  # Single module
  # Create scatter-plot
  output$lineplot <- renderPlot({
    
    if(input$select_crypto == "Bitcoin"){
      selectedInput <- Bitcoin
    }
    else if(input$select_crypto == "Ethereum"){
      selectedInput <- Ethereum
    }
    else if(input$select_crypto == "Doge_Coin"){
      selectedInput <- Doge_Coin
    }
    color = "#434343"
    par(mar = c(4, 4, 1, 1))
    plot(x = selectedInput$Date, y = selectedInput$Close, type = "l", xlab = "Date", ylab = "Closing Price in $", main ="Price vs Time Graph",
         col = "green", fg = color, col.lab = color, col.axis = color)
    
    # Display only if smoother is checked
    if(input$smoother){
      smooth_curve <- lowess(x = as.numeric(selectedInput$Date), y = selectedInput$Close, f = input$f)
      lines(smooth_curve, col = "#E6553A", lwd = 3)
    }
  })
  
  # Display x co-ordinate and price
  output$info <- renderText({
    paste0("Closing Price = ", input$plot_click$y, "0$")
  })
  
  # Create scatter-plot of Market Cap vs Time Graph
  output$lineplot2 <- renderPlot({
    
    if(input$select_crypto == "Bitcoin"){
      selectedInput <- Bitcoin
    }
    else if(input$select_crypto == "Ethereum"){
      selectedInput <- Ethereum
    }
    else if(input$select_crypto == "Doge_Coin"){
      selectedInput <- Doge_Coin
    }
    color = "#434343"
    par(mar = c(4, 4, 1, 1))
    plot(x = selectedInput$Date, y = selectedInput$MarketCap, type = "l", xlab = "Date", ylab = "Market Capitalization in Billion $", main="Market Cap Vs Time Graph",
         col = "blue", col.lab = color, col.axis = color)
    
    # Display only if smoother is checked
    if(input$smoother){
      smooth_curve <- lowess(x = as.numeric(selectedInput$Date), y = selectedInput$MarketCap, f = input$f)
      lines(smooth_curve, col = "#E6553A", lwd = 3)
    }
  })
  
  # Display x co-ordinate and price
  output$info <- renderText({
    paste0("Closing Price = ", input$plot_click$y, "0$")
  })
  
  
  # Compare module
  # Create scatter-plot of Price vs Time Graph
  output$lineplot3 <- renderPlot({
    
    if(input$select_crypto1 == "Bitcoin"){
      selectedInput1 <- Bitcoin
    }
    else if(input$select_crypto1 == "Ethereum"){
      selectedInput1 <- Ethereum
    }
    else if(input$select_crypto1 == "Doge_Coin"){
      selectedInput1 <- Doge_Coin
    }
    if(input$select_crypto2 == "Bitcoin"){
      selectedInput2 <- Bitcoin
    }
    else if(input$select_crypto2 == "Ethereum"){
      selectedInput2 <- Ethereum
    }
    else if(input$select_crypto2 == "Doge_Coin"){
      selectedInput2 <- Doge_Coin
    }
    color = "#434343"
    par(mar = c(4, 4, 1, 1))
    plot(x = selectedInput1$Date, y = selectedInput1$Close, type = "l", main="Price vs Time Chart", xlab = "Date", ylab = "Closing Price in $",
         fg = color, col.lab = color, col.axis = color, col="green")
    lines(selectedInput2$Date,selectedInput2$Close,lty=4,lwd=4,col="blue")
    # Display only if smoother is checked
    if(input$smoother1){
      smooth_curve1 <- lowess(x = as.numeric(selectedInput1$Date), y = selectedInput1$Close, f = input$f1)
      lines(smooth_curve1, lwd = 3,col="red")
      smooth_curve2 <- lowess(x = as.numeric(selectedInput2$Date), y = selectedInput2$Close, f = input$f1)
      lines(smooth_curve2, lwd = 3,col="red")
    }
  })
  
  # Create scatter-plot of Market Cap vs Time Graph
  output$lineplot4 <- renderPlot({
    
    if(input$select_crypto1 == "Bitcoin"){
      selectedInput1 <- Bitcoin
    }
    else if(input$select_crypto1 == "Ethereum"){
      selectedInput1 <- Ethereum
    }
    else if(input$select_crypto1 == "Doge_Coin"){
      selectedInput1 <- Doge_Coin
    }
    if(input$select_crypto2 == "Bitcoin"){
      selectedInput2 <- Bitcoin
    }
    else if(input$select_crypto2 == "Ethereum"){
      selectedInput2 <- Ethereum
    }
    else if(input$select_crypto2 == "Doge_Coin"){
      selectedInput2 <- Doge_Coin
    }
    color = "#434343"
    par(mar = c(4, 4, 1, 1))
    plot(x = selectedInput1$Date, y = selectedInput1$MarketCap, type = "l", main="Market Cap vs Time Chart", xlab = "Date", ylab = "Market Capitalization in Billion $",
         fg = color, col.lab = color, col.axis = color, col="green")
    lines(selectedInput2$Date,selectedInput2$MarketCap,lty=4,lwd=4,col="blue")
    # Display only if smoother is checked
    if(input$smoother1){
      smooth_curve1 <- lowess(x = as.numeric(selectedInput1$Date), y = selectedInput1$MarketCap, f = input$f1)
      lines(smooth_curve1, lwd = 3,col="red")
      smooth_curve2 <- lowess(x = as.numeric(selectedInput2$Date), y = selectedInput2$MarketCap, f = input$f1)
      lines(smooth_curve2, lwd = 3,col="red")
    }
  })
  
  # Prediction module
  # Display prediction
  output$trendPlot <- renderPlot({
    
    mybtcforecast <- forecast(btcmodel, level = c(95), h = input$h)
    autoplot(mybtcforecast, xlab = 'Years(Quarters)', ylab = 'Closing Price in $')
  })
  
}

# Launching app
shinyApp(ui, server)