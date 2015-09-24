library(shiny)
library(poweRlaw)
library(stats)

#normally I would do all/most of the data engineering here, querying db's, loading csv's etc... in this case I'm just generating a set of numbers.
 dataset11 <- rnorm(1000)
 dataset21 <- runif(1000)
 dataset31 <- rpldis(1000, xmin = 2, alpha = 3/2)
