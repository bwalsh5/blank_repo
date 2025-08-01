library(shiny)
library(dplyr)
library(ggplot2)

data <- read.csv("data/vaccine_rates.csv")

ui <- fluidPage(
  titlePanel("Annual Vaccine Rates"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        "state", "Select states:",
        choices = unique(data$state),
        selected = unique(data$state)[1], multiple = TRUE
      ),
      checkboxGroupInput(
        "vaccines", "Vaccines:",
        choices = list(
          "Measles" = "measles",
          "Polio" = "polio",
          "Whooping Cough" = "pertussis"
        ),
        selected = c("measles", "polio", "pertussis")
      ),
      sliderInput(
        "yearRange", "Select year range:",
        min = min(data$year), max = max(data$year),
        value = c(min(data$year), max(data$year)), step = 1, sep = ""
      )
    ),
    mainPanel(plotOutput("vaccinePlot"))
  )
)

server <- function(input, output, session) {
  filtered <- reactive({
    req(input$state)
    dplyr::filter(
      data,
      state %in% input$state,
      year >= input$yearRange[1],
      year <= input$yearRange[2]
    )
  })

  long_data <- reactive({
    filtered() |>
      tidyr::pivot_longer(
        cols = c(measles, polio, pertussis),
        names_to = "vaccine", values_to = "rate"
      )
  })

  output$vaccinePlot <- renderPlot({
    req(input$vaccines)
    plot_data <- dplyr::filter(long_data(), vaccine %in% input$vaccines)
    ggplot(plot_data, aes(x = year, y = rate, color = vaccine)) +
      geom_line() +
      geom_point() +
      facet_wrap(~state) +
      labs(
        y = "Vaccine Coverage (%)",
        x = "Year",
        color = "Vaccine"
      ) +
      theme_minimal()
  })
}

shinyApp(ui, server)
