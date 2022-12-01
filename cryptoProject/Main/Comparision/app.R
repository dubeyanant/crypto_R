library(shiny)
library(shinyWidgets)

mychoices <- c(
  "pick me A",
  "pick me - a very long name here",
  "no pick me - B",
  "another one that is long"
)

ui <-
  navbarPage(
    tabPanel("Dataset description", ),
    tabPanel(
      "Data",
      sidebarPanel(
        width = 3,
        #Dropdown menu for selecting cryptocurrency
        selectInput("select_crypto1", "Select First Cryptocurrency", choices = c("Bitcoin", "Ethereum", "Doge Coin")),
        # Displaying x and y co-ordinates
        verbatimTextOutput("info1"),
        
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
        width = 6,
        # Displaying plot graph
        plotOutput("lineplot2", click = "plot_click"),
        plotOutput("lineplot3", click = "plot_click")
        
      ),
      sidebarPanel(
        width = 3,
        #Dropdown menu for selecting cryptocurrency
        selectInput("select_crypto2", "Select Second  Cryptocurrency", choices = c("Bitcoin", "Ethereum", "Doge Coin")),
        
        
        
      )
    )
  )
server <- function(input, output) {
  
  
  
  # Create scatter-plot of Price vs Time Graph
  output$lineplot2 <- renderPlot({
    
    if(input$select_crypto1 == "Bitcoin"){
      selectedInput1 <- Bitcoin
    }
    else if(input$select_crypto1 == "Ethereum"){
      selectedInput1 <- Ethereum
    }
    else if(input$select_crypto1 == "Doge_Coin"){
      selectedInput1 == Doge_Coin
    }
    if(input$select_crypto2 == "Bitcoin"){
      selectedInput2 <- Bitcoin
    }
    else if(input$select_crypto2 == "Ethereum"){
      selectedInput2 <- Ethereum
    }
    else if(input$select_crypto2 == "Doge_Coin"){
      selectedInput2 == Doge_Coin
    }
    color = "#434343"
    par(mar = c(4, 4, 1, 1))
    plot(x = selectedInput1$Date, y = selectedInput1$Close, type = "l", main="Price vs Time Chart", xlab = "Date", ylab = "Closing Price in $",
          fg = color, col.lab = color, col.axis = color, col="green")
    lines(selectedInput2$Date,selectedInput2$Close,lty=4,lwd=4,col="blue")
    # Display only if smoother is checked
    if(input$smoother){
      smooth_curve1 <- lowess(x = as.numeric(selectedInput1$Date), y = selectedInput1$Close, f = input$f)
      lines(smooth_curve1, lwd = 3,col="red")
      smooth_curve2 <- lowess(x = as.numeric(selectedInput2$Date), y = selectedInput2$Close, f = input$f)
      lines(smooth_curve2, lwd = 3,col="red")
    }
  })
  
  # Display x co-ordinate and price
  output$info <- renderText({
    paste0("x = ", input$plot_click$x, "\nClosing Price = ", input$plot_click$y, "0$")
  })
  
 
  
  # Create scatter-plot of Market Cap vs Time Graph
  output$lineplot3 <- renderPlot({
    
    if(input$select_crypto1 == "Bitcoin"){
      selectedInput1 <- Bitcoin
    }
    else if(input$select_crypto1 == "Ethereum"){
      selectedInput1 <- Ethereum
    }
    else if(input$select_crypto1 == "Doge_Coin"){
      selectedInput1 == Doge_Coin
    }
    if(input$select_crypto2 == "Bitcoin"){
      selectedInput2 <- Bitcoin
    }
    else if(input$select_crypto2 == "Ethereum"){
      selectedInput2 <- Ethereum
    }
    else if(input$select_crypto2 == "Doge_Coin"){
      selectedInput2 == Doge_Coin
    }
    color = "#434343"
    par(mar = c(4, 4, 1, 1))
    plot(x = selectedInput1$Date, y = selectedInput1$Market.Cap, type = "l", main="Market Cap vs Time Chart", xlab = "Date", ylab = "Market Capitalization in $",
         fg = color, col.lab = color, col.axis = color, col="green")
    lines(selectedInput2$Date,selectedInput2$Market.Cap,lty=4,lwd=4,col="blue")
    # Display only if smoother is checked
    if(input$smoother){
      smooth_curve1 <- lowess(x = as.numeric(selectedInput1$Date), y = selectedInput1$Market.Cap, f = input$f)
      lines(smooth_curve1, lwd = 3,col="red")
      smooth_curve2 <- lowess(x = as.numeric(selectedInput2$Date), y = selectedInput2$Market.Cap, f = input$f)
      lines(smooth_curve2, lwd = 3,col="red")
    }
  })
  
  # Display x co-ordinate and price
  output$info <- renderText({
    paste0("x = ", input$plot_click$x, "\nClosing Price = ", input$plot_click$y, "0$")
  })
}


shinyApp(ui, server)

