install.packages('devtools')

devtools::install_github('rstudio/shinyapps')

# set account information
shinyapps::setAccountInfo(name='limminchim', token='902035BDB900A65BBCDC03AF3EE01E86', secret='cdNJNvNTWt+ko/q9qaMhG3Q4ipYjRZJJUvwKnqn6')

library(shinyapps)

# deploy to RStudio Shiny Server
shinyapps::deployApp('F:/Data Science Course/PA91')