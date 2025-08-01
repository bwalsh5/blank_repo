# Vaccine Rate Shiny App

This repository contains a simple Shiny application for visualizing annual vaccine rates for measles, polio, and whooping cough (pertussis) across different US states. The app uses a locally stored CSV dataset and does not fetch live data.

## Data

A sample dataset is provided in `data/vaccine_rates.csv`. Replace this file with real data if desired. The CSV should have the following columns:

- `state` – state name
- `year` – four-digit year
- `measles` – measles vaccine coverage percentage
- `polio` – polio vaccine coverage percentage
- `pertussis` – whooping cough (pertussis) vaccine coverage percentage

To update the dataset from an online source, adjust the URL in `download_data.R` and run:

```bash
Rscript download_data.R
```

## Running the App

Open R or RStudio and run:

```R
shiny::runApp('app.R')
```

The interface lets you pick one or more states, select which vaccines to display, and choose a year range. The resulting plot shows the selected vaccines as colored lines and facets the data by state.
