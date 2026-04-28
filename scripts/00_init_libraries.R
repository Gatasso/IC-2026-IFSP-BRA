initialize_libraries <- function() {
  install.packages("bibliometrix", dependencies = TRUE)
  install.packages("janitor", dependencies = TRUE)
  install.packages("writexl", dependencies = TRUE)
}

initialize_biblioshiny <- function(){
  biblioshiny()
}