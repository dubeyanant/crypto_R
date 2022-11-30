#install.packages("fpp2")

library(shiny)

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
                          plotOutput("lineplot", click = "plot_click")
                        )
                      )
             ),
             
             tabPanel("Compare",
                      sidebarLayout(
                        sidebarPanel(),
                        mainPanel()
                      )
             ),
             
             tabPanel("Prediction",
                      sidebarLayout(
                        sidebarPanel(
                          # select time range to display 
                          sliderInput("n", "Number of Days",
                                      value = c(153, 253),
                                      min = 1,
                                      max = 253
                          ),
                          # days for prediction ahead
                          numericInput("h", "Days to predict", value = 10),
                          
                          # add options for prediction method
                          radioButtons("model", "Model to select",
                                       choices = c("ARIMA", "NeuralNet"),
                                       choiceValues = "ARIMA")
                          
                        ),
                        
                        # Show a plot of the generated distribution
                        mainPanel(
                          plotOutput("trendPlot")
                          
                        )
                      )
             )
  )
)


server <- function(input, output) {
  
  # Create scatter-plot
  output$lineplot <- renderPlot({
    
    if(input$select_crypto == "Bitcoin"){
      selectedInput <- Bitcoin
    }
    else if(input$select_crypto == "Ethereum"){
      selectedInput <- Ethereum
    }
    else if(input$select_crypto == "Doge_Coin"){
      input$select_crypto == Doge_Coin
    }
    color = "#434343"
    par(mar = c(4, 4, 1, 1))
    plot(x = selectedInput$Date, y = selectedInput$Close, type = "l", xlab = "Date", ylab = "Closing Price in $",
         col = color, fg = color, col.lab = color, col.axis = color)
    
    # Display only if smoother is checked
    if(input$smoother){
      smooth_curve <- lowess(x = as.numeric(selectedInput$Date), y = selectedInput$Close, f = input$f)
      lines(smooth_curve, col = "#E6553A", lwd = 3)
    }
  })
  
  # Display x co-ordinate and price
  output$info <- renderText({
    paste0("x = ", input$plot_click$x, "\nClosing Price = ", input$plot_click$y, "0$")
  })
  
  # Display prediction
  output$trendPlot <- renderPlot({
    library(fpp2)
    
    stock <- Bitcoin
    
    end = dim(stock)[1]
    start = end - 100
    
    if (input$model == "ARIMA"){
      mod <- auto.arima(stock[start : end, "Close"])
    } else {
      mod <- nnetar(stock[start : end, "Close"])
    }
    data <- forecast(mod, h = input$h)
    autoplot(forecast(mod, h = input$h)) + ggtitle("Forecast for next 10 Days based on past 100 Days Price")
  })
}

shinyApp(ui, server)