#Mettre les variables numériques sous format numériques, date sous format date, etc
data <- read.csv("stat_acc_V3.csv", header = TRUE, sep = ";")

data$id_usa <- as.numeric(data$id_usa)
data$id_code_insee <- as.numeric(data$id_code_insee)
data$an_nais <- as.numeric(data$an_nais)
data$age <- as.numeric(data$age)
data$place <- as.numeric(data$place)

data$date <- as.Date(data$date)



#Histo 1
# Charger le fichier CSV
data <- read.csv("stat_acc_V3.csv", sep = ";")

# Convertir la colonne 'an_nais' en type numérique
data$an_nais <- as.numeric(data$an_nais)

# Créer des tranches d'âge
data$age <- as.numeric(format(Sys.Date(), "%Y")) - data$an_nais
limites_age <- c(0, 18, 25, 35, 45, 55, 65, 75, 85, 95, 105, 124)
data$tranche_age <- cut(data$age, breaks = limites_age, labels = FALSE, right = FALSE)

# Compter le nombre d'accidents par tranche d'âge
nombre_accidents <- table(data$tranche_age)

# Étiquettes des tranches d'âge
etiquettes <- c("0-17", "18-24", "25-34", "35-44", "45-54", "55-64", "65-74", "75-84", "85-94", "95-104", "105-124")

# Tracer l'histogramme de la quantité d'accidents par tranche d'âge avec les étiquettes
barplot(nombre_accidents, 
        main = "Quantité d'accidents par tranche d'âge",
        xlab = "Tranche d'âge",
        ylab = "Nombre d'accidents",
        names.arg = etiquettes,
        ylim = c(0, 20000))











#Histo 2
# Créer une nouvelle colonne pour le mois
data$mois <- format(data$date, "%Y-%m")

# Calculer la moyenne mensuelle des accidents
moyenne_mensuelle <- aggregate(Num_Acc ~ mois, data, FUN = length)

# Tracer l'histogramme
barplot(moyenne_mensuelle$Num_Acc, 
         names.arg = moyenne_mensuelle$mois, 
         xlab = "Mois", 
         ylab = "Nombre d'accidents", 
         main = "Moyenne mensuelle des accidents")

