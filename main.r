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
affiche_barre_ville()
# affiche_pie_gravite()
# affiche_pie_heure()
# affiche_serie_mois()
#affiche_serie_semaine()
print("fin")