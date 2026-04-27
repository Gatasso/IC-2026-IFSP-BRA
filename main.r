path_directory <- setwd("C:/Users/Pesquisa/Documents/IC2026-MGR")
path_scripts <- paste0(path_directory,"/scripts")
path_run <- paste0(path_directory, "/search_runs/")

source(paste0(path_scripts,"/00_init_libraries.r"))
source(paste0(path_scripts,"/01_import_raw_files.r"))
source(paste0(path_scripts,"/02_convert_files.r"))
source(paste0(path_scripts,"/03_clean_data.r"))
source(paste0(path_scripts,"/04_export_converted_files.r"))

RUN_PATH <- paste0(path_run, "02_270426/")

initialize_bibliometrix()
initialize_libraries()
raw_data_map <- import_data(RUN_PATH)
converted_files <- convert_data(raw_data_map, "bibtex")


initialize_biblioshiny()