library(tidyverse)
library(vcd)

# Charger les données depuis le fichier CSV
data <- read.csv("redol.csv", sep=";")

# Regrouper les catégories de la variable descr_type_col
data <- data %>%
  mutate(descr_type_col = recode(descr_type_col,
                                 "Deux véhicules - Frontale" = "Deux collis",
                                 "Deux véhicules – Par l’arrière" = "Deux collis",
                                 "Deux véhicules – Par le coté" = "Deux collis",
                                 "Trois véhicules et plus – Collisions multiples" = "Trois collis",
                                 "Trois véhicules et plus – En chaîne" = "Trois collis",
                                 "Autre collision" = "Autre",
                                 "Sans collision" = "Sans"))

# Réaliser un tableau croisé entre deux variables
tableau_croise1 <- table(data$descr_type_col, data$descr_athmo)
tableau_croise2 <- table(data$descr_lum, data$descr_athmo)

# Créer une nouvelle fenêtre graphique
dev.new()

# Graphe 1
mosaicplot(tableau_croise1, main = "Tableau croisé 1", shade = TRUE,
           color = TRUE, las = 1, cex.axis = 1, cex.lab = 1, cex = 0.8)

# Créer une autre fenêtre graphique
dev.new()

# Graphe 2
mosaicplot(tableau_croise2, main = "Tableau croisé 2", shade = TRUE,
           color = TRUE, las = 1, cex.axis = 1, cex.lab = 1, cex = 0.8)
