initialize_bibliometrix <- function() {
  install.packages("bibliometrix")
  library(bibliometrix)
  biblioshiny()
}

initialize_libraries <- function() {
  install.packages("janitor")
  library(janitor)
  library(dplyr)
}