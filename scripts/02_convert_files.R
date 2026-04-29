convert_data <- function(df_map) {
  library(bibliometrix)
  library(dplyr)
  df_final <- NULL
  
  for (i in 1:nrow(df_map)) {
    f      <- df_map$file[i]
    db     <- df_map$database[i]
    string <- df_map$search_string[i]
    
    ext <- tools::file_ext(f)
    # Para WoS .txt, o formato ideal costuma ser "fieldtagged"
    formato_bibliometrix <- ifelse(ext == "csv", "csv", "plaintext") 
    
    message(paste("===> Processando:", basename(f), "| Base:", db))
    
    df <- tryCatch({
      temp_df <- convert2df(
        file = f, 
        dbsource = db, 
        format = formato_bibliometrix
      )
      
      # Verifica se o dataframe foi criado e possui linhas
      if (is.null(temp_df) || nrow(temp_df) == 0) {
        message(paste("Aviso: Arquivo", basename(f), "não gerou dados (vazio ou formato incompatível). Ignorando..."))
        NULL
      } else {
        temp_df
      }
    }, error = function(e) {
      message(paste("Erro ao converter arquivo:", basename(f), "-", e$message))
      return(NULL)
    })
    
    if (!is.null(df)) {
      df$SOURCE_DB <- db
      df$SEARCH_STRING <- string
      df_final <- dplyr::bind_rows(df_final, df)
    }
  }
  
  if (is.null(df_final)) {
    stop("Erro Crítico: Nenhum dado foi convertido com sucesso. Verifique os formatos de exportação.")
  }
  
  return(df_final)
}