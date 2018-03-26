library(shiny)

ui <- fluidPage(
  sliderInput(inputId = "n",
              label = "Choose the total number of coin tosses",
              value = 10, min = 1, max = 20),
  plotOutput("density")
)
