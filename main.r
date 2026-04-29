# Configurações de Caminho
path_directory <- setwd("C:/Users/Pesquisa/Documents/IC2026-MGR")
path_scripts   <- paste0(path_directory, "/scripts")
path_run       <- paste0(path_directory, "/search_runs/")

# Carrega as definições das funções (Source) de uma só vez
invisible(lapply(list.files(path_scripts, pattern = "\\.[Rr]$|\\.r$", full.names = TRUE), source))

# --- PREENCHIMENTO MANUAL ---
RUN_FOLDER <- "03_290426/" 
# ----------------------------

run_bibliometrix_pipeline <- function(folder_name) {
  target_path <- paste0(path_run, folder_name)
  
  message("________Iniciando Pipeline________")
  
  initialize_libraries()
  
  # Fluxo de Dados
  data_raw       <- import_data(target_path)
  data_converted <- convert_data(data_raw)
  data_cleaned   <- clean_and_merge_data(data_converted)
  
  # Exportação dos Arquivos
  export_bib_data(data_cleaned, target_path)
  
  message("________Pipeline concluído________")
  
  # Abre a interface do Biblioshiny
  biblioshiny()
}

# Execução Única
run_bibliometrix_pipeline(RUN_FOLDER)

