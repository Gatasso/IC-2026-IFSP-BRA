convert_data <- function(df_map, file_format) {
  library(bibliometrix)
  df_final <- NULL
  
  # Percorremos as linhas do dataframe de mapeamento
  for (i in 1:nrow(df_map)) {
    f      <- df_map$file[i]
    db     <- df_map$database[i]
    string <- df_map$search_string[i]
    
    message(paste("===> Processando:", basename(f), "| Base:", db))
    
    df <- tryCatch({
      # Forçamos o Bibliometrix a usar a base que mapeamos
      convert2df(
        file = f, 
        dbsource = db, 
        format = file_format
      )
    }, error = function(e) {
      message(paste("Erro no arquivo:", f, "-", e$message))
      return(NULL)
    })
    
    if (!is.null(df)) {
      df$SOURCE_DB <- db
      df$SEARCH_STRING <- string
      df_final <- rbind(df_final, df)
    }
  }
  return(df_final)
}