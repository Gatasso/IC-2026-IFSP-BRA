convert_data <- function(df_map, file_format) {
  library(bibliometrix)
  df_final <- NULL
  
  # Percorre as linhas do dataframe de mapeamento, atribuindo os valores em variáveis
  for (i in 1:nrow(df_map)) {
    f      <- df_map$file[i]
    db     <- df_map$database[i]
    string <- df_map$search_string[i]
    
    message(paste("===> Processando:", basename(f), "| Base:", db))
    
    # converte os arquivos .bib em DF com metadados bibliográficos
    df <- tryCatch({
      # uso das informações mapeadas
      convert2df(
        file = f, 
        dbsource = db, 
        format = file_format
      )
    }, error = function(e) {
      message(paste("Erro no arquivo:", f, "-", e$message))
      return(NULL)
    })
    
    # se o dataframe convertido não estiver vazio, vincula as informações
    # da base e da string de busca no DF final
    if (!is.null(df)) {
      df$SOURCE_DB <- db
      df$SEARCH_STRING <- string
      #df_final <- rbind(df_final, df)
      df_final <- dplyr::bind_rows(df_final, df)
    }
  }
  return(df_final)
}