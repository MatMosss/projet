# source("RdeJuju.r")
library(ggplot2)
library(sqldf)
# library(dplyr)
# library(maps)
# library(rmapshaper)
library(sf)
library(stringr)


main <- function(){
    affiche_pie_athmo()
    affiche_pie_surface()
    #affiche_barre_ville()
    affiche_pie_gravite()
    #affiche_pie_heure()
    affiche_serie_mois(0)
    affiche_serie_semaine(0)
    affiche_serie_mois(1)
    affiche_serie_semaine(1)
    download_graph_departement()
    download_graph_regions()
}