convert_data <- function(files, file_format) {
  library(bibliometrix)
  df_final <- NULL
  
  #percorre todos os arquivos importados
  for (file in files) {
    db <- basename(dirname(dirname(file)))
    string <- basename(dirname(file))
    print(file)
    print(db)
    
    df<- convert2df(
      file = file,
      dbsource = db,
      format = file_format 
    )
    # adiciona informação de base e string de busca para auxiliar em possíveis
    #análises futuras
    df$SOURCE_DB <- db
    df$SEARCH_STRING <- string
    df_final <- rbind(df_final, df)
    print(df)
  }
  print(df_final)
  return(df_final)
}