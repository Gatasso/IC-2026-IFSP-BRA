export_bib_data <- function(df_final, RUN_PATH) {
  library(bibliometrix)
  library(writexl)
  
  message("\n--- Iniciando Exportação dos Dados ---")
  start_time <- Sys.time() # variável para marcação de tempo de processo
  
  # Define os caminhos completos usando a RUN_PATH da main.r
  output_file_csv  <- paste0(RUN_PATH, "final_database.csv")
  output_file_rds  <- paste0(RUN_PATH, "final_database.rds")
  output_file_xlsx <- paste0(RUN_PATH, "final_database.xlsx")
  
  message(paste("Destino:", RUN_PATH))
  
  # 1. Exportação RDS, preservando as colunas AU, DE, ID e C1 sem perda de tipo de dado
  tryCatch({
    saveRDS(df_final, file = output_file_rds)
    message("Exportação para Formato RDS concluído com sucesso.")
  }, error = function(e) {
    message("Erro na exportação em Formato RDS: ", e$message)
  })
  
  # 2. Exportação CSV usando o separador ";"
  tryCatch({
    write.table(df_final, 
                file = output_file_csv, 
                sep = ";", 
                row.names = FALSE, 
                fileEncoding = "UTF-8")
    message("Exportação para Formato CSV concluído com sucesso.")
  }, error = function(e) {
    message("Erro na exportação em Formato CSV: ", e$message)
  })
  
  # 3. Exportação XLSX
  tryCatch({ 
    df_export <- df_final
    rownames(df_export) <- NULL
    # Converte colunas que podem ser listas em strings para evitar erros
    df_export <- data.frame(lapply(df_export, function(x) {
      if (is.list(x)) return(sapply(x, paste, collapse = "; "))
      x <- as.character(x)
      if (any(nchar(x, keepNA = FALSE) > 32000)) {
        x <- ifelse(nchar(x) > 32000, paste0(substr(x, 1, 31990), "[TRUNCATED]"), x)
      }
      return(x)
    }))
    
    write_xlsx(df_export, path = output_file_xlsx)
    message("Exportação para Formato XLSX concluída com sucesso.")
  }, error = function(e) {
    message("Erro na exportação em Formato XLSX: ", e$message)
  })
  
  duration <- round(difftime(Sys.time(), start_time, units = "secs"), 2)
  message(paste("Processo concluído em:", duration, "segundos."))
}