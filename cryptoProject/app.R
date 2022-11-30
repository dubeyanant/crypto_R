library(shiny)

ui <- fluidPage(
  titlePanel("Cryptocurrency"),
  
  sidebarLayout(
    sidebarPanel(
      # Select date range to be plotted
      dateRangeInput("date", strong("Date range"), start = "2013-04-28", end = "2022-11-21",
                     min = "2013-04-28", max = "2022-11-21"),
      
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
)



server <- function(input, output) {
  
  # Create scatter plot object the plot Output function is expecting
  output$lineplot <- renderPlot({
    color = "#434343"
    #par(mar = c(4, 4, 1, 1))
    plot(x = df$Date, y = df$Close, type = "l", xlab = "Date", ylab = "Closing Price", col = color, fg = color, col.lab = color, col.axis = color)
    
    # Display only if smoother is checked
    if(input$smoother){
      smooth_curve <- lowess(x = as.numeric(df$Date), y = df$Close, f = input$f)
      lines(smooth_curve, col = "#E6553A", lwd = 3)
    }
  })
  
  output$info <- renderText({
    paste0("x=", input$plot_click$x, "\ny=", input$plot_click$y)
  })
}

shinyApp(ui, server)