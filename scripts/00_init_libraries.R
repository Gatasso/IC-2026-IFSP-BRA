initialize_libraries <- function() {
  install.packages("bibliometrix", dependencies = TRUE)
  install.packages("janitor", dependencies = TRUE)
}

initialize_biblioshiny <- function(){
  biblioshiny()
}