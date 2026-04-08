import_data <- function(RUN_PATH) {
  # atribui à files todos os arquivos em todas as subpastas do piloto
  files <- list.files(
      path = RUN_PATH,
      pattern = "\\.bib$",
      recursive = TRUE,
      full.names = TRUE
    )
  # Recorta metadata do path e adiciona como contexto em um dataframe, auxiliando na conversão
  #para df no bibliometrix
  # A extração do metadata foi desenvolvido para a estrutura de diretórios deste projeto
  #sendo necessário idealizar uma forma mais dinâmica
  files_df <- data.frame(
    file = files,
    database = basename(dirname(dirname(files))),
    search_string = basename(dirname(files)),
    stringsAsFactors = FALSE
  )
  return(files)
}