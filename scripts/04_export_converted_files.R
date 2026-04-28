export_bib_data <- function(df_final, RUN_PATH) {
  library(bibliometrix)
  
  message("\n--- Iniciando Exportação dos Dados ---")
  start_time <- Sys.time() # variável para marcação de tempo de processo
  
  # Define os caminhos completos usando a RUN_PATH da main.r
  output_file_csv <- paste0(RUN_PATH, "final_database.csv")
  output_file_rds <- paste0(RUN_PATH, "final_database.rds")
  
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
  
  duration <- round(difftime(Sys.time(), start_time, units = "secs"), 2)
  message(paste("Processo concluído em:", duration, "segundos."))
}