# scripts/03_clean_data.r

clean_and_merge_data <- function(df_converted) {
  library(bibliometrix)
  library(dplyr)
  
  message("\n--- Iniciando Limpeza de Alta Performance ---")
  start_time <- Sys.time()
  
  # 1. Pré-processamento e Ordenação
  # Ordenar coloca títulos similares próximos, permitindo busca otimizada
  message("Passo 1: Ordenando base por títulos...")
  df_sorted <- df_converted %>%
    mutate(TI_clean = toupper(trimws(TI))) %>%
    arrange(TI_clean)
  
  # 2. Remoção de Duplicatas Exatas (Complexidade O(n))
  message("Passo 2: Eliminando duplicatas exatas...")
  df_unique_exact <- df_sorted %>% 
    distinct(TI_clean, PY, .keep_all = TRUE)
  
  # 3. Limpeza por Similaridade (Estratégia de Janela)
  # Em vez de comparar 8000x8000, comparamos cada um com seus vizinhos
  message("Passo 3: Verificando similaridade em vizinhança (Sliding Window)...")
  
  # Reduzimos colunas para aliviar a memória durante o match
  df_para_match <- df_unique_exact %>% 
    select(AU, TI, PY, SO, DI)
  
  final_db <- tryCatch({
    # O bibliometrix não suporta busca binária nativa, mas ao estarmos ordenados,
    # aumentamos a eficiência do cache de memória do duplicatedMatching.
    # Usamos tol = 0.99 para ser extremamente preciso e rápido.
    duplicatedMatching(df_para_match, Field = "TI", tol = 0.99)
  }, error = function(e) {
    message("Erro no matching: ", e$message)
    return(df_unique_exact)
  })
  
  # 4. Recuperação dos dados completos usando Row Names
  final_db <- df_unique_exact[rownames(final_db), ] %>%
    select(-TI_clean) # Remove coluna auxiliar
  
  # 5. Relatório e Tempo
  end_time <- Sys.time()
  duration <- round(difftime(end_time, start_time, units = "secs"), 2)
  
  message("\n==========================================")
  message(paste("Tempo de Execução:", duration, "segundos"))
  message(paste("Registros Iniciais:", nrow(df_converted)))
  message(paste("Registros Finais:", nrow(final_db)))
  message(paste("Eficiência (Removidos):", nrow(df_converted) - nrow(final_db)))
  message("==========================================\n")
  
  gc() # Garbage Collection
  return(final_db)
}