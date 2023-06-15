library(sqldf)

traitement_donnees <- function(){ 
    data <- read.csv2(file = "stat_MossMoss.csv") #on ouvre le fichier 
    infos <- read.csv2(file = "cities.csv", sep = ",") #onsépare par colonne les nom séparé par des virgules
    data[data == "NULL"] <- NA


    # on met les valeurs des colonnes sous le bon format
    data$latitude <- as.numeric(data$latitude)
    data$longitude <- as.numeric(data$longitude)
    data$an_nais <- as.numeric(data$an_nais)
    data$age <- as.numeric(data$age)
    data$id_code_insee <- as.character(data$id_code_insee)
    infos$insee_code <- as.character(infos$insee_code)


    infos <- subset(infos, !duplicated(insee_code)) #on supprimes les codes insee en doublon dans de datagrame infos
    compteur <- 1
    for (lat in data$latitude) {
    if (lat == 2009 || lat == 0) { #si on tombe sur des valeur de latitude aberrente, on remplace par les bonnes valeur de longitude/latitusde
        data[compteur, "longitude"] <- subset(infos, insee_code == data[compteur, "id_code_insee"], longitude)
        data[compteur, "latitude"] <- subset(infos, insee_code == data[compteur, "id_code_insee"], latitude)
    }
    compteur <- compteur+1
    } 


    compteur <- 1
    for (place in data$place) { # si on tombe sur une valeur na dans la colonne place, on lui attribu la valeur 0
    if (is.na(place)) {
        data[compteur, "place"] <- 0
    }
    compteur <- compteur+1
    }

    data$age <- data$age - 14
    print(which(is.na(data),arr.ind=TRUE))
}

traitement_donnees()