#Mettre les variables numériques sous format numériques, date sous format date, etc
data <- read.csv("stat_acc_V3.csv", header = TRUE, sep = ";")

data$id_usa <- as.numeric(data$id_usa)
data$id_code_insee <- as.numeric(data$id_code_insee)
data$an_nais <- as.numeric(data$an_nais)
data$age <- as.numeric(data$age)
data$place <- as.numeric(data$place)

data$date <- as.Date(data$date)

# Histogramme : tranches d'âges
x11()
hist(data$age, breaks = "Sturges", xlab = "Âge", ylab = "Nombre d'accidents", main = "Quantité d'accidents en fonction des tranches d'âges")

#  moyenne mensuelle des accidents
data$mois <- format(data$date, "%m")
mean_accidents_mois <- aggregate(place ~ mois, data, mean)

# Histogramme : mensuelle des accidents
x11()
barplot(mean_accidents_mois$place, names.arg = mean_accidents_mois$mois, xlab = "Mois", ylab = "Moyenne des accidents", main = "Moyenne mensuelle des accidents")
print(mean_accidents_mois)
