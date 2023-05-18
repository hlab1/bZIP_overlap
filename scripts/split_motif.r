options(scipen=999)

suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(tidyr))

args = commandArgs(trailing = TRUE)
input_file = args[1]
output_folder = args[2]

df = read.table(input_file, header = FALSE)

df = df %>%
	filter(!grepl("amp", V4)) %>%
	mutate(V4 = gsub(".*\\.", "", V4), V4 = gsub("_.*", "", V4)) %>%
	group_by(V4)

keys = group_keys(df)$V4

list = group_split(df)
names(list) = keys

for (i in 1:length(list)) {
	out_file = paste0(output_folder, names(list)[i], "_motif.bed")
	df = list[[i]]
	df = df %>%
		mutate(id = 1:nrow(df), V4 = paste0(V4, "_", id)) %>%
		select(-id)
	write.table(df, out_file, sep = '\t', quote = FALSE, row.names = FALSE, col.names = FALSE)
}