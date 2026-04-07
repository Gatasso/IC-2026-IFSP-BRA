install.packages("bibliometrix")
library(bibliometrix)

scopus <- convert2df("C:/Users/Pesquisa/Documents/IC2026-MGR/scopus/export.csv",dbsource ="scopus",format="csv")
wos <- convert2df("C:/Users/Pesquisa/Documents/IC2026-MGR/wos/savedrecs.txt",dbsource ="wos",format="plaintext")
full_db <- mergeDbSources(scopus,wos, remove.duplicated = TRUE)
write.table(full_db, "C:/Users/Pesquisa/Documents/IC2026-MGR/dados_bib.csv", sep = ";", row.names = FALSE)


