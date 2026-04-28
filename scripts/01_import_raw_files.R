import_data <- function(RUN_PATH) {
  # Armazena os nomes de todos os arquivos bibtex da search_run especificada em RUN_PATH
  files <- list.files(
    path = RUN_PATH,
    pattern = "\\.csv$", # limita à apenas arquivos .csv
    recursive = TRUE, # permite busca nas sub-pastas
    full.names = TRUE
  )
  
  # Cria DataFrame, mapeando a base com a string de busca
  files_df <- data.frame(
    file = files,
    # Conversão forçada para minúsculo para evitar "Scopus" vs "scopus"
    database = tolower(basename(dirname(dirname(files)))),
    search_string = basename(dirname(files)),
    stringsAsFactors = FALSE
  )
  
  # RETORNO IMPORTANTE: Retornamos o dataframe completo
  return(files_df) 
}