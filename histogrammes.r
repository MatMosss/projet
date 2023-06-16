library("ggplot2")
Histogramme <- function() {
  #histogramme de la quantité d'accidents par tranche d'âge
  # Charger le fichier CSV
  data <- read.csv("csv/stat_acc_V3.csv", sep = ";")
  
  # Convertir la colonne 'an_nais' en type numérique
  data$an_nais <- as.numeric(data$an_nais)
  
  # Créer: tranches d'âge
  data$age <- as.numeric(format(Sys.Date(), "%Y")) - data$an_nais
  limites_age <- c(0, 18, 25, 35, 45, 55, 65, 75, 85, 95, 105, 124)
  data$tranche_age <- cut(data$age, breaks = limites_age, labels = FALSE, right = FALSE)
  
  # Compter le nombre d'accidents par tranche d'âge
  nombre_accidents <- table(data$tranche_age)
  
  # Étiquettes
  etiquettes <- c("0-17", "18-24", "25-34", "35-44", "45-54", "55-64", "65-74", "75-84", "85-94", "95-104", "105-124")
  
  # Tracer l'histogramme de la quantité d'accidents par tranche d'âge 
  dfetiquette = data.frame(nombre_accidents, etiquettes)
  print(dfetiquette)
  hist1 <- ggplot(dfetiquette, aes(etiquettes, nombre_accidents, fill = etiquettes)) +
          geom_bar(stat = "identity") +
    labs(title = "Nombre d'accidents par tranche d'âge",
         x = "tranche d'âge", y = "Nombre d'accidents") +
    theme(plot.title = element_text(face = "bold", hjust = 0.5)) +
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
    scale_fill_discrete()
    ggsave("histogramme/histogrammetrancheage.png",plot = hist1, dpi =300)

  #histogramme de Moyenne mensuelle des accidents
  # Créer une nouvelle colonne pour le mois
  data$date <- as.Date(data$date)
  
  data$mois <- format(data$date, "%Y-%m")
  
  # Calculer la moyenne mensuelle des accidents
  moyenne_mensuelle <- aggregate(Num_Acc ~ mois, data, FUN = length)
  dfmensuelle = data.frame(moyenne_mensuelle$Num_Acc, moyenne_mensuelle$mois)
  print(dfmensuelle)
  # Tracer l'histogramme
  hist2 <- ggplot(dfmensuelle, aes(moyenne_mensuelle$mois, moyenne_mensuelle$Num_Acc, fill = moyenne_mensuelle$mois)) +
          geom_bar(stat = "identity") +
    labs(title = "Moyenne mensuelle des accidents",
         x = "Mois", y = "Nombre d'accidents") +
    theme(plot.title = element_text(face = "bold", hjust = 0.5)) +
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
    scale_fill_discrete()
    ggsave("histogramme/histogrammemoyennemois.png",plot = hist2, dpi =300)
}


# main <- function() {
#   Histogramme()
# }
# main()
