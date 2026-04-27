export_bib_data <- function(df_final, RUN_PATH) {
  library(bibliometrix)
  
  message("\n--- Iniciando Exportação dos Dados ---")
  start_time <- Sys.time()
  
  # Define os caminhos completos usando a RUN_PATH da main.r
  output_file_csv <- paste0(RUN_PATH, "final_database_bibliometrix.csv")
  output_file_rds <- paste0(RUN_PATH, "final_database.rds")
  
  message(paste("Destino:", RUN_PATH))
  
  # 1. Exportação RDS (Recomendado para carregar no R/Bibliometrix)
  # Preserva as colunas AU, DE, ID e C1 sem perda de tipo de dado
  tryCatch({
    saveRDS(df_final, file = output_file_rds)
    message("✔ Arquivo RDS gerado com sucesso.")
  }, error = function(e) {
    message("✘ Erro ao salvar RDS: ", e$message)
  })
  
  # 2. Exportação CSV (Para conferência manual ou Excel)
  # Usamos o separador ";" conforme seus testes iniciais de sucesso
  tryCatch({
    write.table(df_final, 
                file = output_file_csv, 
                sep = ";", 
                row.names = FALSE, 
                fileEncoding = "UTF-8")
    message("✔ Arquivo CSV gerado com sucesso.")
  }, error = function(e) {
    message("✘ Erro ao salvar CSV: ", e$message)
  })
  
  duration <- round(difftime(Sys.time(), start_time, units = "secs"), 2)
  message(paste("Processo concluído em:", duration, "segundos."))
}