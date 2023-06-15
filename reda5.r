library(ggplot2)

data <- read.csv("redol.csv", sep=";")

fonction_visu <- function(colonne, cumule){
  list_nb <- vector("numeric", 0)
  
  list_type <- vector("character", 0)
  if(cumule == 0){
    compteur <- 0}
  for (elt in unique(colonne)){
    compteur <- 0
    for (element in colonne){
      if (element == elt) {
        compteur <- compteur + 1
      }
    }
    
    list_nb <- c(list_nb, compteur)
    list_type <- c(list_type, elt)
  }
  return(list(list_nb = list_nb, list_type = list_type))
}



affiche_pie_athmo <- function(){
  valeur <- fonction_visu(data$descr_cat_veh, 0)
  
  valeur1 <- valeur$list_nb
  valeur2 <- valeur$list_type
  dfathmo <- data.frame(valeur1 = valeur$list_nb, valeur2 = valeur$list_type)
  figure <- ggplot(data = dfathmo, aes(x = "", y = valeur1, fill = valeur2)) +
    geom_bar(stat = "identity", width = 1) +
    coord_polar(theta = "y") +
    labs(title = "Répartition des accidents en fonction 
        des catégorie de description du véhicule") +
    theme_void()
  print("sachant qu'en moyenne il pleut 15,2% du temps 
(24*365/576 où 576 est le nombre d'heure de pluie légère en moyenne 
en france en 2019) or 7296/73563*100 = 10% d'accident lié à la pluie legère
on ne peut en déduire que les accidents dépendent 
de conditions atmosphériques ")
  print(figure)
}

affiche_pie_athmo()




library(tidyverse)
library(vcd)

# Charger les données depuis le fichier CSV
data <- read.csv("redol.csv", sep=";")

# Extraire les 20000 premières lignes de données
data <- head(data, 20000)

# Créer une nouvelle fenêtre graphique
dev.new()

# Regrouper les données par région et catégorie de véhicule
data_grouped <- data %>%
  group_by(region, descr_cat_veh) %>%
  summarise(Nombre_d_accidents = n())

# Créer un tableau croisé entre région et catégorie de véhicule
tableau_croise <- table(data_grouped$descr_cat_veh, data_grouped$region)

# Graphe
mosaicplot(tableau_croise, main = "Tableau croisé entre Catégorie de véhicule et Région", shade = TRUE,
           color = TRUE, las = 1, cex.axis = 0.8, cex.lab = 0.8)

print(tableau_croise)


# Supposons que votre dataframe s'appelle "data" et que la colonne contenant les villes est appelée "ville"

# Extraire les villes uniques
villes_uniques <- unique(data$ville)

# Afficher les villes uniques
print(villes_uniques)







# ----------
# Charger les données à partir du fichier CSV
data <- read.csv("redol.csv", sep=";")



# Extraire les valeurs uniques de la variable "descr_athmo"
unique_descr_athmo <- unique(data$description_intersection)

# Créer un tableau avec les valeurs uniques de "descr_athmo"
descr_secu_df <- data.frame(description_intersection= unique_descr_athmo)

# Afficher le tableau des valeurs uniques de "descr_athmo"
print(descr_secu_df)

