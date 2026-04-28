clean_and_merge_data <- function(df_list) {
  library(dplyr)
  library(bibliometrix)
  library(tictoc)
  
  cat("Iniciando processamento de", length(df_list), "arquivos...\n")
  tic("Tempo Total de Limpeza")
  
  # 1. Unificação inicial (Dividir)
  tic("Fase 1: Unificação (bind_rows)")
  raw_combined <- bind_rows(df_list)
  toc()
  
  # 2. Tratamento de Duplicatas (Conquistar)
  
  # A. Prioridade 1: DOI (DI) - Hashing de alta velocidade
  tic("Fase 2A: Deduplicação por DOI")
  with_doi <- raw_combined %>% 
    filter(!is.na(DI) & DI != "") %>% 
    distinct(DI, .keep_all = TRUE)
  toc()
  
  # B. Prioridade 2: Título Normalizado (Para registros sem DOI)
  tic("Fase 2B: Deduplicação por Título Normalizado")
  without_doi <- raw_combined %>% 
    filter(is.na(DI) | DI == "") %>%
    mutate(temp_title = toupper(gsub("[^[:alnum:]]", "", TI))) %>%
    distinct(temp_title, .keep_all = TRUE) %>%
    select(-temp_title)
  toc()
  
  # 3. Merge Final e Refinamento
  tic("Fase 3: Merge final e Similaridade")
  final_df <- bind_rows(with_doi, without_doi)
  
  # Opcional: Apenas se o volume permitir, pois tol = 0.95 é pesado
  # final_df <- duplicatedMatching(final_df, Field = "TI", tol = 0.95)
  toc()
  
  cat("\n--- Resumo de Desempenho ---\n")
  toc() # Fecha o Tempo Total
  
  cat("Artigos iniciais:", nrow(raw_combined), "\n")
  cat("Artigos após limpeza:", nrow(final_df), "\n")
  
  return(final_df)
}

# Execução no fluxo principal (main.r)
# converted_files <- convert_data(raw_data_map, "bibtex")
data_cleaned <- clean_and_merge_data(converted_files)