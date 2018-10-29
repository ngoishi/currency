fluidPage(
  titlePanel("Exchange Rate Forecasts"),
  fluidRow(
    sliderInput("forward", "Forecast window size (months):", min = 1, max = 12, value = 6, step = 1),
           plotOutput("plot1", width = 1200, height = 900)
  )
)
