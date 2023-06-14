install.packages("corrplot")
# Charger les packages nécessaires
library(tidyverse)
library(ggplot2)
library(corrplot)

# Charger les données depuis le fichier CSV
data <- read.csv("redol.csv", sep=";")

# Tester la corrélation entre descr_athmo et descr_lum
cor_test_athmo_lum <- chisq.test(table(data$descr_athmo, data$descr_lum))
print(cor_test_athmo_lum)

# Créer un graphique pour la corrélation entre descr_athmo et descr_lum
mosaicplot(table(data$descr_athmo, data$descr_lum), main = "Corrélation entre descr_athmo et descr_lum", shade = TRUE)

# Tester la corrélation entre descr_cat_veh et descr_grav
cor_test_cat_veh_grav <- chisq.test(table(data$descr_cat_veh, data$descr_grav))
print(cor_test_cat_veh_grav)

# Créer un graphique pour la corrélation entre descr_cat_veh et descr_grav
mosaicplot(table(data$descr_cat_veh, data$descr_grav), main = "Corrélation entre descr_cat_veh et descr_grav", shade = TRUE)

# Tester la corrélation entre descr_athmo et descr_etat_surf
cor_test_athmo_surf <- chisq.test(table(data$descr_athmo, data$descr_etat_surf))
print(cor_test_athmo_surf)

# Créer un graphique pour la corrélation entre descr_athmo et descr_etat_surf
mosaicplot(table(data$descr_athmo, data$descr_etat_surf), main = "Corrélation entre descr_athmo et descr_etat_surf", shade = TRUE)

# Tester la corrélation entre descr_agglo et descr_motif_traj
cor_test_agglo_motif <- chisq.test(table(data$descr_agglo, data$descr_motif_traj))
print(cor_test_agglo_motif)

# Créer un graphique pour la corrélation entre descr_agglo et descr_motif_traj
mosaicplot(table(data$descr_agglo, data$descr_motif_traj), main = "Corrélation entre descr_agglo et descr_motif_traj", shade = TRUE)

# Tester la corrélation entre descr_lum et descr_type_col
cor_test_lum_type_col <- chisq.test(table(data$descr_lum, data$descr_type_col))
print(cor_test_lum_type_col)

# Créer un graphique pour la corrélation entre descr_lum et descr_type_col
mosaicplot(table(data$descr_lum, data$descr_type_col), main = "Corrélation entre descr_lum et descr_type_col", shade = TRUE)

# Calculer la matrice de corrélation pour toutes les variables
cor_matrix <- cor(data[, c("descr_athmo", "descr_lum", "descr_cat_veh", "descr_grav", "descr_etat_surf", "descr_agglo", "descr_motif_traj", "descr_type_col")])
print(cor_matrix)

# Créer un graphique de corrélation
corrplot(cor_matrix, method = "circle", tl.col = "black", tl.srt = 45)

