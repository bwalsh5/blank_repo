library(RColorBrewer)
library(tidyverse)
data(mtcars)

cyl_count <- mtcars %>%
  group_by(cyl) %>%
  summarize(count = n())

# Create the plot
cyl_count |> 
ggplot(aes(as.factor(cyl), count, fill = as.factor(cyl))) +
  geom_col() +
  scale_fill_brewer(palette = "Set3") +
  labs(x = "Number of Cylinders", y = "Number of Cars", fill = "Cylinders") +
  theme_minimal()
