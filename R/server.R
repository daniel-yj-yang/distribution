library(shiny)

server <- function(input, output) {
  output$density <- renderPlot({
    x <- seq(0,input$n,by=1)
    y <- dbinom(x,input$n,0.5)
    plot(x,y,xlab=paste("Number of heads out of", input$n, "coin tosses"),ylab="Probability")
    lines(x,y)
  }, width=600)
}