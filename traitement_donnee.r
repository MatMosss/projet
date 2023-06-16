#sauvegarde dans dossier csv le fichier stat_data_IA.csv qui nous sera utile pour le projet d'IA
traitement_donnees <- function(){ 
    data <- read.csv2(file = "csv/stat_MossMoss.csv") #on ouvre le fichier 
    infos <- read.csv2(file = "csv/cities.csv", sep = ",") #onsépare par colonne les nom séparé par des virgules
    data[data == "NULL"] <- NA

    # on met les valeurs des colonnes sous le bon format
   
    data$latitude <- as.numeric(data$latitude)
    data$longitude <- as.numeric(data$longitude)
    data$an_nais <- as.numeric(data$an_nais)
    data$age <- as.numeric(data$age)
    data$id_code_insee <- as.character(data$id_code_insee)
    data$date <- as.Date(data$date)
    data$place <- as.numeric(data$place)

    
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
    data$descr_agglo[data$descr_agglo == "Hors agglomération"] <- 0
    data$descr_agglo[data$descr_agglo == "En agglomération"] <- 1
    data$descr_agglo <- as.numeric(data$descr_agglo)

    data$descr_lum[data$descr_lum == "Plein jour"] <- 0
    data$descr_lum[data$descr_lum == "Crépuscule ou aube"] <- 1
    data$descr_lum[data$descr_lum == "Nuit avec éclairage public allumé"] <- 2
    data$descr_lum[data$descr_lum == "Nuit avec éclairage public non allumé"] <- 3
    data$descr_lum[data$descr_lum == "Nuit sans éclairage public"] <- 4
    data$descr_lum <- as.numeric(data$descr_lum)


    data$descr_grav[data$descr_grav == "Indemne"] <- 0
    data$descr_grav[data$descr_grav == "Blessé léger"] <- 1
    data$descr_grav[data$descr_grav == "Blessé hospitalisé"] <- 2
    data$descr_grav[data$descr_grav == "Tué"] <- 3
    data$descr_grav <- as.numeric(data$descr_grav)


    listj = as.list(unique(data$descr_cat_veh))
    j = 0;
    for (elt in listj){
        data$descr_cat_veh[data$descr_cat_veh==elt] <- j;
        j = j + 1 

    }

    write.csv(data, "csv/stat_data_IA.csv", row.names = FALSE)

}
