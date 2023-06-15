
nom_ligne <- length(unique(population$descr_grav))
nom_col <- unique(population$region_name)

df <- data.frame(matrix(nrow =length(unique(population$region_name)) , ncol = length(unique(population$descr_grav))))
colnames(df) <- unique(population$descr_grav)
rownames(df) <- unique(population$region_name)
# for (i in 1:nrow(df)) {
#   for (j in 1:ncol(df)) {
#     masque <- population[population$descr_grav == nom_col[j] & df$region_name == nom_ligne[i]]
#     print(masque)
#     # df[j, i] <- masque
#   }
# }
# print(row.names(df[1,]))
# print(colnames(df[,1]))
# print(population[population$descr_grav == 2] )
print(subset(population, region_name == population[1, "region_name"] & descr_grav == population[1, "descr_grav"], pr_100000))
