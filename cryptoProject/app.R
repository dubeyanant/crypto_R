library(shiny)

ui <- fluidPage(
  navbarPage("Crypto Data",
             tabPanel("Single",titlePanel("Cryptocurrency"),
  titlePanel("Cryptocurrency"),
  
  sidebarLayout(
    sidebarPanel(
      #Dropdown menu for selecting cryptocurrency
      selectInput("select_crypto", "Select Cryptocurrency", choices = c("Bitcoin", "Ethereum", "Doge Coin")),
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
  tabPanel("Compare")
  )
)



server <- function(input, output) {
  
  
  
  # Create scatter-plot
  output$lineplot <- renderPlot({
    if(input$select_crypto == "Bitcoin"){
      color = "#434343"
      par(mar = c(4, 4, 1, 1))
      plot(x = Bitcoin$Date, y = Bitcoin$Close, type = "l", xlab = "Date", ylab = "Closing Price in $",
           col = color, fg = color, col.lab = color, col.axis = color)
      
      # Display only if smoother is checked
      if(input$smoother){
        smooth_curve <- lowess(x = as.numeric(Bitcoin$Date), y = Bitcoin$Close, f = input$f)
        lines(smooth_curve, col = "#E6553A", lwd = 3)
      }
    }
  })
  
  # Display x co-ordinate and price
  output$info <- renderText({
    paste0("x = ", input$plot_click$x, "\nClosing Price = ", input$plot_click$y, "0$")
  })
}

shinyApp(ui, server)