path_directory <- setwd("C:/Users/Pesquisa/Documents/IC2026-MGR")
path_scripts <- paste0(path_directory,"/scripts")
path_run <- paste0(path_directory, "/search_runs/")

source(paste0(path_scripts,"/00_init_libraries.r"))
source(paste0(path_scripts,"/01_import_raw_files.r"))
source(paste0(path_scripts,"/02_convert_files.r"))
source(paste0(path_scripts,"/03_clean_data.r"))
source(paste0(path_scripts,"/04_export_converted_files.r"))

RUN_PATH <- paste0(path_run, "02_270426/")

initialize_libraries()
run_scripts()
data_raw_imported <- import_data(RUN_PATH)
data_converted <- convert_data(data_raw_imported, "bibtex")
data_cleaned <- clean_and_merge_data(data_converted)
export_bib_data(data_cleaned, RUN_PATH)

initialize_biblioshiny()
