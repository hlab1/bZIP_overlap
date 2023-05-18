options(scipen=999)

suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(tidyr))
suppressPackageStartupMessages(library(tidyverse))

args = commandArgs(trailing = TRUE)
input_folder = args[1]
output_file = args[2]
id_loc = args[3]
vari_loc = args[4]

list_file = list.files(input_folder)

df_meta <- data.frame(name = character(),
	num_peak = integer(),
	num_peak_with_vari = integer(),
	vari_ratio = double())

variType = c("SNP", "CPG", "CPL", "HDR", "TDM", "INS", "DEL")
variType = paste(variType, collapse="|")

for (file in list_file) {
	df = read.table(paste0(input_folder, file))
	name = gsub(".overlap.*", "", file)
	num_peak = length(unique(df[[id_loc]]))
	df = df %>%
		select(matches(c(id_loc, vari_loc))) %>%
		filter(grepl(variType, get(vari_loc)))
	num_peak_with_vari = length(unique(df[[id_loc]]))
	vari_ratio = num_peak_with_vari / num_peak

	df_meta = df_meta %>% add_row(name = name, num_peak = num_peak, num_peak_with_vari = num_peak_with_vari, vari_ratio = vari_ratio)
}

df_meta = df_meta %>% separate(name, sep = "_", into = c("name", "accession"))
write.csv(df_meta, output_file, quote = FALSE, row.names = FALSE)