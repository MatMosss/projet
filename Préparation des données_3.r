
data <- read.csv("stat_acc_V3 (1).csv", sep = ";")

data$descr_grav <- as.numeric(data$descr_grav)
data$place <- as.numeric(data$place)
data$age <- as.numeric(data$age)
data$an_nais <- as.numeric(data$an_nais)
data$longitude <- as.numeric(data$longitude)
data$latitude <- as.numeric(data$latitude)
data$id_usa <- as.numeric(data$id_usa)
data$Num_Acc <- as.numeric(data$Num_Acc)
data$id_code_insee <- as.numeric(data$id_code_insee)
stat_acc_V3 <- read.csv("stat_acc_V3.csv", sep = ";")

data$ville <- as.character(data$ville)

data$date <- as.Date(data$date)

data$villes <- stat_acc_V3$ville

data$Num_Ac <- stat_acc_V3$Num_Acc

write.csv(data, "nouveau_fichier.csv", row.names = FALSE)
