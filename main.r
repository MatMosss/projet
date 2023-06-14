source("RdeJuju.r")
library(ggplot2)
BDD <- read.csv2(file = "stat_juju.csv")
library(ggplot2)
BDD[BDD == "NULL"] <- " NA"
dim(BDD)
names(BDD)
summary(BDD)
head(BDD)
nombre <- dim(BDD)[1]
print(nombre)
counts <- unique(BDD$descr_athmo)
BDD$descr_grav[BDD$descr_grav == "Indemne"] <- 0
BDD$descr_grav[BDD$descr_grav == "Blessé léger"] <- 1
BDD$descr_grav[BDD$descr_grav == "Blessé hospitalisé"] <- 2
BDD$descr_grav[BDD$descr_grav == "Tué"] <- 3
BDD2 <- read.csv2(file = "stat_juju3.csv", sep = ",")
# affiche_pie_athmo()
# affiche_pie_surface()
# affiche_barre_ville()
# affiche_pie_gravite()
# affiche_pie_heure()
# affiche_serie_mois()
# affiche_serie_semaine()

print("fin")
library(ggplot2)
library(maps)
library(mapdata)
library(ggmap)

data <- data.frame(
  region_name = c("Île-de-France", "Provence-Alpes-Côte d'Azur", "Auvergne-Rhône-Alpes"),
  nombre_accidents = c(500, 300, 200),
  couleur = c("blue", "green", "red")
)

# Obtenez les données géographiques pour la France
france_map <- map_data("france")

# Fusionnez les données géographiques avec les données de nombre d'accidents par région
merged_data <- merge(france_map, data, by.x = "region", by.y = "region_name", all.x = TRUE)

# Créez le graphique
print(ggplot() +
  geom_polygon(data = merged_data, aes(x = long, y = lat, group = group, fill = couleur)) +
  labs(title = "Nombre d'accidents par région en France") +
  scale_fill_manual(values = data$couleur) +
  theme_void())