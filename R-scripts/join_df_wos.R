install.packages("bibliometrix")
install.packages("janitor")
library(bibliometrix)
library(janitor)
library(dplyr)

wos_str1_1 <- convert2df(
  "C:/Users/Pesquisa/Documents/IC2026-MGR/Piloto-070426/wos_str01_artigos_1.bib",
  dbsource = "wos",
  format = "bibtex",
  remove.duplicates = TRUE)
wos_str1_2 <- convert2df(
  "C:/Users/Pesquisa/Documents/IC2026-MGR/Piloto-070426/wos_str01_artigos_2.bib",
  dbsource = "wos",
  format = "bibtex",
  remove.duplicates = TRUE)

compare_df_cols(wos_str1_1,wos_str1_2)

wos_str1 <- bind_rows(wos_str1_1,wos_str1_2)
saveRDS(object = wos_str1, file = "C:/Users/Pesquisa/Documents/IC2026-MGR/Piloto-070426/wos_str01.rds")
write.table(wos_str1, "C:/Users/Pesquisa/Documents/IC2026-MGR/Piloto-070426/wos_str01.rds", sep = ";", row.names = FALSE)

