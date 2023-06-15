source("Matisse_traitement_donnee.r")
source("Matisse_sql.r")
source("RdeJuju.r")
source("histogrammes.r")
<<<<<<< HEAD
source("population100.R")
source("regression.R")
=======
source("tests d’indépendance du chi2.r")
>>>>>>> ee6dfbdc8b94720db280874708296350e0305141

# library(sqldf)
# library(dplyr)
# library(maps)
# library(ggplot2)
# library(rmapshaper)
# library(sf)
# library(stringr)
library(tidyverse)
library(vcd)
library(grid)
library(factoextra)
require(FactoMineR)



main <- function(){
    # traitement_donnees()
<<<<<<< HEAD
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
    Histogramme()
<<<<<<< HEAD
    regressions()
    ACP()
}
=======
    tests_tableaux_indépendance ()
}
>>>>>>> d5fbf63c575aecde445883775110ac1c09cb4da1
=======
    # affiche_pie_athmo()
    # affiche_pie_surface()
    # #affiche_barre_ville()
    # affiche_pie_gravite()
    # #affiche_pie_heure()
    # affiche_serie_mois(0)
    # affiche_serie_semaine(0)
    # affiche_serie_mois(1)
    # affiche_serie_semaine(1)
    # download_graph_departement()
    # download_graph_regions()
    #Histogramme()
    tests_tableaux_independance ()
}

>>>>>>> ee6dfbdc8b94720db280874708296350e0305141
