#library
library(tidyverse)
library(vcd)
library(grid)

# Charger les données depuis le fichier CSV
data <- read.csv("stat_acc_V3.csv", sep=";")

#-1-----------------------------------------------------------------------------

#filtrage
data<- data %>%
  filter(descr_motif_traj != "Autre" )

# Réaliser un tableau croisé entre deux variables
tableau_croise1 <- table(data$descr_grav, data$descr_motif_traj)

# Créer une nouvelle fenêtre graphique
dev.new()

# Graphe 1
tab1<-mosaicplot(tableau_croise1, main = "Tableau croisé 1: entre description de la gravité des blessures et la description du motif du trajet", shade = TRUE,
           color = TRUE, las = 1, cex.axis = 0.8, cex.lab = 0.8)
dev.copy(png, file.path("Tableaux", "graph2.png"))
dev.off() 

print(tableau_croise1)



#-2-----------------------------------------------------------------------------


# Renommer les niveaux de la variable descr_type_col
data$place <- recode(data$place,
                                       
                     "6" = "6\n~\n10",
                     "7" = "6\n~\n10",
                     "8" = "6\n~\n10",
                     "9" = "6\n~\n10",
                     "NULL" = "6\n~\n10"
                     )

# Réaliser un tableau croisé entre deux variables
tableau_croise2 <- table(data$place, data$descr_grav)

# Créer une nouvelle fenêtre graphique
dev.new()

# Graphe 2
tab2<-mosaicplot(tableau_croise2, main = "Tableau croisé 2: entre description de la gravité des blessures et la place occupée dans le véhicule", shade = TRUE,
           color = TRUE, las = 1, cex.axis = 0.8, cex.lab = 0.8)
dev.copy(png, file.path("Tableaux", "graph2.png"))
dev.off() 
print(tableau_croise2)

#-3---------------------------------
#filtrage

data<- data %>%
  filter(descr_dispo_secu != "Présence d'une ceinture de sécurité - Utilisation non déterminable" &
           descr_dispo_secu != "Autre - Non déterminable" &
           descr_dispo_secu != "Présence d'un casque - Utilisation non déterminable" &
           descr_dispo_secu != "Présence dispositif enfant - Utilisation non déterminable" &
           descr_dispo_secu != "Autre - Utilisé" &
           descr_dispo_secu != "Autre - Non utilisé" &
           descr_dispo_secu != "Présence équipement réfléchissant - Utilisation non déterminable")

# Renommer les niveaux de la variable descr_dispo_secu

data$descr_dispo_secu<-recode(data$descr_dispo_secu,
                                             "Utilisation d'une ceinture de sécurité " = "Ceinture de sécurité",
                                             "Utilisation d'un casque " = "Casque",
                                             "Présence de ceinture de sécurité non utilisée " = "Ceinture de sécurité non utilisée",
                                             "Présence d'un équipement réfléchissant non utilisé" = "Équipement réfléchissant non utilisé",
                                             "Présence d'un casque non utilisé " = "Casque non utilisé",
                                             "Utilisation d'un dispositif enfant" = "Dispositif enfant",
                                             "Utilisation d'un équipement réfléchissant" = "Équipement réfléchissant",
                                             "Présence d'un dispositif enfant non utilisé" = "Dispositif enfant non utilisé")
# Réaliser un tableau croisé entre deux variables
tableau_croise3 <- table(data$descr_grav, data$descr_dispo_secu)

# Créer une nouvelle fenêtre graphique
dev.new()

# Graphe 3
tab3<-mosaicplot(tableau_croise3, main = "Tableau croisé 3: entre description de la gravité des blessures et description de la disponibilité de l'équipement de sécurité utilisé", shade = TRUE,
           color = TRUE, las = 1, cex.axis = 0.6, cex.lab = 0.8)
dev.copy(png, file.path("Tableaux", "graph3.png"))
dev.off() 
print(tableau_croise3)

#-4---------------------------------
#filtrage
data<- data %>%
  filter(description_intersection != "Présence d'une ceinture de sécurité - Utilisation non déterminable" )

# Réaliser un tableau croisé entre deux variables
tableau_croise4 <- table(data$descr_grav, data$description_intersection)

# Créer une nouvelle fenêtre graphique
dev.new()

# Graphe 4
tab4<-mosaicplot(tableau_croise4, main = "Tableau croisé 4: entre description de la gravité des blessures et la description de l'intersection", shade = TRUE,
           color = TRUE, las = 1, cex.axis = 0.8, cex.lab = 0.8)
dev.copy(png, file.path("Tableaux", "graph4.png"))
dev.off() 
print(tableau_croise4)

#-5---------------------------------

# Réaliser un tableau croisé entre deux variables
tableau_croise5 <- table(data$descr_grav, data$descr_agglo)

# Créer une nouvelle fenêtre graphique
dev.new()

# Graphe 5
tab5<-mosaicplot(tableau_croise5, main = "Tableau croisé 5: entre description de la gravité des blessures et la description de l'environnement urbain où s'est produit l'accident", shade = TRUE,
           color = TRUE, las = 1, cex.axis = 0.8, cex.lab = 0.8)
dev.copy(png, file.path("Tableaux", "graph5.png"))
dev.off() 
print(tableau_croise5)

#-6---------------------------------

# Filtrer les données pour exclure les catégories indésirables
filtered_data <- data %>%
  filter(descr_type_col != "Autre collision" & descr_type_col != "Sans collision")

# Supprimer la catégorie "Autre" de descr_athmo
filtered_data <- filtered_data %>%
  filter(descr_athmo != "Autre")

# Renommer les niveaux de la variable descr_type_col
filtered_data$descr_type_col <- recode(filtered_data$descr_type_col,
                                       "Deux véhicules - Frontale" = "2 - frontale",
                                       "Deux véhicules – Par l’arrière" = "2 – par l’arrière",
                                       "Deux véhicules – Par le coté" = "2 – par le coté",
                                       "Trois véhicules et plus – En chaîne" = "3 ou + \n en chaîne",
                                       "Trois véhicules et plus – Collisions multiples" = "3 ou +\ncollisions \nmultiples\n")

# Réaliser un tableau croisé entre deux variables
tableau_croise6 <- table(filtered_data$descr_type_col, filtered_data$descr_athmo)

# Créer une nouvelle fenêtre graphique
dev.new()

# Graphe 6
tab6<-mosaicplot(tableau_croise6, main = "Tableau croisé 6: entre Type de collisions et états d'atmosphérique", shade = TRUE,
           color = TRUE, las = 1, cex.axis = 0.8, cex.lab = 0.8)
dev.copy(png, file.path("Tableaux", "graph6.png"))
dev.off() 

print(tableau_croise6)

#-7------------------------------

# Supprimer et filtrage
data <- data %>%
  filter(description_intersection != "Autre intersection")



#rennomer
data$descr_lum<-recode(data$descr_lum,
                       "Nuit sans éclairage public" = "Nuit sans éclair. pub.",
                       "Plein jour" = "Plein jour",
                       "Nuit avec éclairage public allumé" = "Nuit avec éclair\n.pub. allu.",
                       "Nuit avec éclairage public non allumé" = "Nuit avec éclair. pub. non allu.",
                       "Crépuscule ou aube" = "Crépuscule ou aube")



# Réaliser un tableau croisé entre deux variables
tableau_croise7 <- table( data$description_intersection,data$descr_lum)

# Créer une nouvelle fenêtre graphique
dev.new()

# Graphe 7
tab7<-mosaicplot(tableau_croise7, main = "Tableau croisé 7: entre description de l'intersection et description de la luminosité", shade = TRUE,
           color = TRUE, las = 2, cex.axis = 0.8, cex.lab = 0.8)

dev.copy(png, file.path("Tableaux", "graph7.png"))
dev.off() 
print(tableau_croise7)


#-8--------------------------------

#filtrage
data<- data %>%
  filter(descr_athmo != "Autre" )

data<- data %>%
  filter(descr_etat_surf != "Autre" )

# Réaliser un tableau croisé entre deux variables
tableau_croise8 <- table(data$descr_etat_surf,data$descr_athmo )

# Créer une nouvelle fenêtre graphique
dev.new()

# Graphe 8
tab8<-mosaicplot(tableau_croise8, main = "Tableau croisé 8: entre description de l'état de la surfaces et description des conditions atmosphériques", shade = TRUE,
           color = TRUE, las = 2, cex.axis = 0.7, cex.lab = 0.8)
dev.copy(png, file.path("Tableaux", "graph8.png"))
dev.off() 
print(tableau_croise8)

#-test----------chi2-----------------------
# Avant de commencer le test du chi-carré, nous faisons l'hypothèse que les deux variables de chaque tableau sont indépendantes


test_chi2_1 <- chisq.test(tableau_croise1)
print(test_chi2_1)
residues <- residuals(test_chi2_1, "stdres")
print(residues)


test_chi2_2 <- chisq.test(tableau_croise2)
print(test_chi2_2)
residues <- residuals(test_chi2_2, "stdres")
print(residues)

test_chi2_3 <- chisq.test(tableau_croise3)
print(test_chi2_3)
residues <- residuals(test_chi2_3, "stdres")
print(residues)

test_chi2_4 <- chisq.test(tableau_croise4)
print(test_chi2_4)
residues <- residuals(test_chi2_4, "stdres")
print(residues)

test_chi2_5 <- chisq.test(tableau_croise5)
print(test_chi2_5)
residues <- residuals(test_chi2_5, "stdres")
print(residues)

test_chi2_6 <- chisq.test(tableau_croise6)
print(test_chi2_6)
residues <- residuals(test_chi2_6, "stdres")
print(residues)

test_chi2_7 <- chisq.test(tableau_croise7)
print(test_chi2_7)
residues <- residuals(test_chi2_7, "stdres")
print(residues)

test_chi2_8 <- chisq.test(tableau_croise8)
print(test_chi2_8)
residues <- residuals(test_chi2_8, "stdres")
print(residues)
## Les résultats des tests du chi-carré montrent que le p-value est inférieur à 0,05 pour tous les tests (p-value < 2.2e-16), cela indique que notre hypothese est  rejetée est  les  variables sont dépendantes

