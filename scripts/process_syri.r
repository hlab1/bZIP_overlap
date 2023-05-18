options(scipen=999)

suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(tidyr))

args = commandArgs(trailing = TRUE)
input_folder = args[1]
output_folder = args[2]

list_file = list.files(input_folder)

for (file in list_file) {
	df = read.table(paste0(input_folder, file))
	df = df %>%
		filter(V11 != "NOTAL") %>%
		mutate(V1 = gsub("Chr", "chr", V1),
			V6 = gsub("Chr", "chr", V6),
			V2 = as.numeric(V2) - 1, V3 = as.numeric(V3), V7 = as.numeric(V7) - 1, V8 = as.numeric(V8),
			refstart = pmin(V2, V3), refend = pmax(V2, V3), qstart = pmin(V7, V8), qend = pmax(V7, V8)) %>%
		select(c(V1, refstart, refend, V4, V5, V6, qstart, qend, V9, V10, V11, V12))
	out_file = paste0(output_folder, gsub(".out", ".out.bed", file))
	write.table(df, out_file, sep = "\t", quote = FALSE, row.names = FALSE, col.names = FALSE)
}