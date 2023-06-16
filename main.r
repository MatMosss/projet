source("traitement_donnee.r")
source("maps.r")
source("représentations_graphiques.r")
source("histogrammes.r")
source("population100.R")
source("regression.R")
source("tests_dindependance_du_chi2.r")


library(sqldf)
library(dplyr)
library(maps)
library(ggplot2)
library(rmapshaper)
library(sf)
library(stringr)
library(tidyverse)
library(vcd)
library(grid)
library(factoextra)
library(FactoMineR)



main <- function(){
    traitement_donnees()
    affiche_pie_athmo()
    affiche_pie_surface()
    affiche_barre_ville()
    affiche_pie_gravite()
    affiche_pie_heure()
    affiche_serie_mois(0)
    affiche_serie_semaine(0)
    affiche_serie_mois(1)
    affiche_serie_semaine(1)
    download_graph_departement()
    download_graph_regions()
    Histogramme()

    #Créer les modèles de régression linéaire, les affiche ainsi que leur summary() et anova()
    regressions()
    tests_tableaux_independance()

    #Applique l'ACP sur le jeu de données pour 100 000 (population2_100) et un bonus
    ACP()
}

main()