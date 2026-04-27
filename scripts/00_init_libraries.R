initialize_bibliometrix <- function() {
  install.packages("bibliometrix", dependencies = TRUE)
  library(bibliometrix)
}

initialize_libraries <- function() {
  install.packages("janitor", dependencies = TRUE)
  library(janitor)
  library(dplyr)
}

initialize_biblioshiny <- function(){
  biblioshiny()
}