source("traitement_donnee.r")
source("maps.r")
source("représentations_graphiques.r")
source("histogrammes.r")
source("population100.R")
source("regression.R")
source("tests_dindependance_du_chi2.r")

#librairie utile à l'exécussion du code
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

    #sauvegarde dans dossier csv le fichier stat_data_IA.csv qui nous sera utile pour le projet d'IA
    traitement_donnees()

    #stock diagramme camembert dans "figure/figureathmo.png"
    affiche_pie_athmo()

    #stock diagramme camembert dans "figure/figuresurface.png"
    affiche_pie_surface()

    #stock diagramme barre dans "figure/figureville.png"
    affiche_barre_ville()

    #stocke diagramme camembert dans "figure/figuregrav.png"
    affiche_pie_gravite()

    #stocke diagramme barre dans "figure/figureheure.png"
    affiche_pie_heure()

    #stocke série chronologique dans fichier/figureseriemois.png
    affiche_serie_mois(0)

    #stocke série chronologique dans fichier/figureseriesemaine.png
    affiche_serie_semaine(0)

    #stocke série chronologique dans fichier/figureseriemois.png
    affiche_serie_mois(1)

    #stocke série chronologique dans fichier/figureseriesemainecumul.png
    affiche_serie_semaine(1)

    #permet de sauvegarder dans dossier png les différentes cartes des departement
    download_graph_departement()

    #permet de sauvegarder dans dossier png les différentes cartes des regions
    download_graph_regions()

    #stocke histogramme de la quantité d'accidents par tranche d'âge dans fichier histogramme
    Histogramme()

    #Créer les modèles de régression linéaire, les affiche ainsi que leur summary() et anova()en console
    regressions()

    # affiche en console des tableaux croisé entre deux variables
    tests_tableaux_independance()

    #Applique la méthode PCA sur les deux jeux de données, affiche les scores des eigenvalues 
    # et doit afficher l'éboulis des eigenvalues aisni que les graphes d'individus et de variables
    # cet affichage fonctionne sur RStudio mais pas sur VSCode pour une raison qui nous est inconnue
    ACP()
}

main()