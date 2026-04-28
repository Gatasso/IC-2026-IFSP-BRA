clean_and_merge_data <- function(df_list) {
  library(dplyr)
  library(bibliometrix)
  
  # Mensagens na tela sobre o processo
  cat("Iniciando processamento de", length(df_list), "arquivos...\n")
  start_time <- Sys.time()
  
  # 1. Conversão em Único Objeto
  raw_combined <- bind_rows(df_list) # reúne todos os registros em linhas, permitindo o trabalho com índices
  
  # 2. Tratamento de Duplicatas
  # Busca por DOI (DI)
  with_doi <- raw_combined %>% 
    filter(!is.na(DI) & DI != "") %>% #busca por registros onde o DI está preenchido
    distinct(DI, .keep_all = TRUE) #remove registros com mesmo DOI em complexidade O(n)
  
  # Busca por Título em registros sem DOI
  without_doi <- raw_combined %>% 
    filter(is.na(DI) | DI == "") %>% #busca por registros onde o DI não está preenchido
    mutate(temp_title = toupper(gsub("[^[:alnum:]]", "", TI))) %>% #cria uma nova coluna, removendo símbolos e espaços, evitando manter duplicados por variação de título
    distinct(temp_title, .keep_all = TRUE) %>% # remove os duplicados, através da coluna nova
    select(-temp_title) #exclui a coluna temporaria
  
  # 3. Merge
  final_df <- bind_rows(with_doi, without_doi) #reune as colunas sem e com DOI
  
  if ("SR" %in% names(final_df)) {
    final_df$SR <- make.unique(as.character(final_df$SR))
  }
  
  cat("\n--- Resumo de Desempenho ---\n")
  duration <- round(difftime(Sys.time(), start_time, units = "secs"), 2) # Fecha o Tempo Total
  cat(paste("Processo concluído em:", duration, "segundos."))
  cat("Artigos iniciais:", nrow(raw_combined), "\n")
  cat("Artigos removidos: ", (nrow(raw_combined) - nrow(final_df)))
  cat("Artigos finais:", nrow(final_df), "\n")
  
  return(final_df)
}