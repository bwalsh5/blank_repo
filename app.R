library(shiny)
library(dplyr)
library(ggplot2)

data <- read.csv("data/vaccine_rates.csv")

ui <- fluidPage(
  titlePanel("Annual Vaccine Rates"),
  sidebarLayout(
    sidebarPanel(
      selectInput("state", "Select states:",
                  choices = unique(data$state),
                  selected = unique(data$state)[1], multiple = TRUE),
      sliderInput("yearRange", "Select year range:",
                  min = min(data$year), max = max(data$year),
                  value = c(min(data$year), max(data$year)), step = 1, sep = "")
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Measles", plotOutput("measlesPlot")),
        tabPanel("Polio", plotOutput("polioPlot")),
        tabPanel("Pertussis", plotOutput("pertussisPlot"))
      )
    )
  )
)

server <- function(input, output, session) {
  filtered <- reactive({
    req(input$state)
    dplyr::filter(data, state %in% input$state,
                  year >= input$yearRange[1], year <= input$yearRange[2])
  })

  output$measlesPlot <- renderPlot({
    ggplot(filtered(), aes(x = year, y = measles, color = state)) +
      geom_line() + geom_point() +
      labs(y = "Measles Vaccine Rate", x = "Year") +
      theme_minimal()
  })

  output$polioPlot <- renderPlot({
    ggplot(filtered(), aes(x = year, y = polio, color = state)) +
      geom_line() + geom_point() +
      labs(y = "Polio Vaccine Rate", x = "Year") +
      theme_minimal()
  })

  output$pertussisPlot <- renderPlot({
    ggplot(filtered(), aes(x = year, y = pertussis, color = state)) +
      geom_line() + geom_point() +
      labs(y = "Whooping Cough Vaccine Rate", x = "Year") +
      theme_minimal()
  })
}

shinyApp(ui, server)
