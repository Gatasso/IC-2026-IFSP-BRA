import_data <- function(RUN_PATH) {
  files <- list.files(
    path = RUN_PATH,
    pattern = "\\.bib$",
    recursive = TRUE,
    full.names = TRUE
  )
  
  # Criamos o mapeamento explícito
  files_df <- data.frame(
    file = files,
    # Forçamos a conversão para minúsculo para evitar "Scopus" vs "scopus"
    database = tolower(basename(dirname(dirname(files)))),
    search_string = basename(dirname(files)),
    stringsAsFactors = FALSE
  )
  
  # RETORNO IMPORTANTE: Retornamos o dataframe completo
  return(files_df) 
}