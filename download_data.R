# Example script to download vaccine rate data
# Replace the URL with a real data source as needed

url <- 'https://example.com/path/to/vaccine_rates.csv'

if (!dir.exists('data')) dir.create('data')

tryCatch({
  download.file(url, destfile = 'data/vaccine_rates.csv', mode = 'wb')
  message('Data downloaded successfully')
}, error = function(e) {
  message('Failed to download data: ', e$message)
})
