library(ggplot2)
BDD <- read.csv2(file = "stat_juju.csv")
library(ggplot2)
BDD[BDD == "NULL"] <- " NA"
dim(BDD)
names(BDD)
summary(BDD)
head(BDD)
nombre <- dim(BDD)[1]
counts <- unique(BDD$descr_athmo)
BDD$descr_grav[BDD$descr_grav == "Indemne"] <- 0
BDD$descr_grav[BDD$descr_grav == "Blessé léger"] <- 1
BDD$descr_grav[BDD$descr_grav == "Blessé hospitalisé"] <- 2
BDD$descr_grav[BDD$descr_grav == "Tué"] <- 3
fonction_visu <- function(colonne, cumule){
    list_nb <- vector("numeric", 0)
    valeur <- 0
    list_type <- vector("character", 0)
    compteur <- 0
    for (elt in unique(colonne)){
       
        if(cumule == 0){
            compteur <- 0}
        if(cumule == 1){
            valeur <- valeur + valeur
    }
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
    valeur <- fonction_visu(BDD$descr_athmo, 0)

    valeur1 <- valeur$list_nb
    valeur2 <- valeur$list_type
    dfathmo <- data.frame(valeur1 = valeur$list_nb, valeur2 = valeur$list_type)
    figure <- ggplot(data = dfathmo, aes(x = "", y = valeur1, fill = valeur2)) +
        geom_bar(stat = "identity", width = 1) +
        coord_polar(theta = "y") +
        labs(title = "Répartition des accidents en fonction 
        des conditions atmosphériques") +
        theme_void()
    print("sachant qu'en moyenne il pleut 15,2% du temps 
(24*365/576 où 576 est le nombre d'heure de pluie légère en moyenne 
en france en 2019) or 7296/73563*100 = 10% d'accident lié à la pluie legère
on ne peut en déduire que les accidents dépendent 
de conditions atmosphériques ")
    print(figure)
}
affiche_pie_surface <- function(){
    surface <- fonction_visu(BDD$descr_etat_surf, 0)
    surf1 <- surface$list_nb
    surf2 <- surface$list_type
    dfathmo <- data.frame(surf1 = surface$list_nb, surf2 = surface$list_type)

    figure1 <- ggplot(data = dfathmo, aes(x = "", y = surf1, fill = surf2)) +
        geom_bar(stat = "identity", width = 1) +
        coord_polar(theta = "y") +
        labs(title = "Répartition des accidents en fonction 
        de la surface") +
        theme_void()
    print("Ici on peut voir que sur sol mouillé, 
    12250/73643*100 = 16,6% or il pleut en moyenne 15% du temps 
    et la pluie peut mettre du temps à sécher, 
    on ne peut pas conclure que les accidents sont lié à la surface")
    print(figure1)
    }
affiche_barre_ville <- function(){
    ville <- fonction_visu(BDD$ville, 0)
    ville1 <- ville$list_nb[ville$list_nb > 500]
    ville2 <- ville$list_type[ville$list_nb > 500]
    dfville <- data.frame(ville1, ville2)
    figure <- ggplot(dfville, aes(x = ville2, y = ville1, fill = ville2)) +
    geom_bar(stat = "identity") +
    labs(title = "Nombre d'accidents par ville",
         x = "Ville", y = "Nombre d'accidents") +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
    scale_fill_gradient(low = "blue", high = "red")
    #scale_fill_viridis_d()
    print(figure)
    }

affiche_pie_heure <- function(){
    date <- BDD$date
    listV <- c(0, 0, 0, 0, 0, 0)
    listV <- as.numeric(listV)
    print(listV)
    compteur =0
    for(elt in date){
        compteur = compteur +1
        heure <- substr(elt, start=12, stop=20)
        splitH <- strsplit(heure, split= ":")
        for(i in seq(4, 28, by = 4)){
            if( i-4 < as.numeric(splitH[[1]][1]) && as.numeric(splitH[[1]][1]) < i){
            nb = i/4
            listV[nb] = listV[nb]+1
        }
    }
    }
    
    tranche_heure = c("0-4h", "4-8h", "8-12h", "12-16h", "16-20h", "20-24h")
    dfheure <- data.frame(listV, tranche_heure)
    figure2 <- ggplot(data = dfheure, aes(x = "", y = listV, fill = tranche_heure)) +
        geom_bar(stat = "identity", width = 1) +
        coord_polar(theta = "y") +
        labs(title = "Répartition des accidents en fonction 
        des conditions atmosphériques") +
        theme_void()
    print(figure2)
}
affiche_pie_gravite <- function(){
    gravite <- fonction_visu(BDD$descr_grav, 0)
    grav1 <- gravite$list_nb
    grav2 <- gravite$list_type
    dfgrav <- data.frame(grav1, grav2)
    figure1 <- ggplot(data = dfgrav, aes(x = "", y = grav1, fill = grav2)) +
        geom_bar(stat = "identity", width = 1) +
        coord_polar(theta = "y") +
        labs(title = "Répartition des accidents en fonction 
        de la surface") +
        theme_void()
    print(figure1)
}

ecriture_csv <- function(){
    listeVide = c()
    for(elt in BDD$date){
        mois <- substr(elt, start=6, stop=7)
        listeVide <- append(listeVide, mois)
    }
    BDD$mois <- listeVide

    BDD$date1 <- as.Date(BDD$date, format = "%Y-%m-%d %H:%M:%S")
    BDD$semaine <- format(BDD$date1, "%U")
    write.csv(BDD, "stat_juju3.csv", row.names = FALSE)
}
BDD2 <- read.csv2(file = "stat_juju3.csv", sep = ",")

affiche_serie_mois <- function(){
    valeur1 <- fonction_visu(BDD2$mois, 1)
    nbaccident <- valeur1$list_nb
    numois <- valeur1$list_type

    dictionnaire_mois <- c("Janvier", "Février", "Mars", "Avril", "Mai", "Juin", "Juillet", "Août", "Sept", "Octo", "Nov", "Déc")
    print(nbaccident)
    print(numois)
    numois <- as.numeric(numois)
    dfmois = data.frame(nbaccident, numois)
    print(dfmois)
    figure2 <- ggplot(data = dfmois, aes(x = numois, y = nbaccident)) +
    geom_line() +
        labs(title = "Répartition des accidents en fonction 
             des conditions atmosphériques", x = "les mois", y = "Nombre d'accidents" ) +
        theme_minimal()
    print(figure2)
 }
 # geom_point() + geom_line() +
affiche_serie_semaine <- function(){
    valeur2 <- fonction_visu(BDD2$semaine, 1)  
    nbaccidentparsemaine <- valeur2$list_nb
    numsemaine <- valeur2$list_type
    numsemaine <- as.numeric(numsemaine)
    numsemaine <- sort(numsemaine)
    nbaccidentparsemaine <- nbaccidentparsemaine[order(numsemaine)]

    dfsemaine = data.frame(nbaccidentparsemaine, numsemaine)
    figure4 <- ggplot(data = dfsemaine, aes(x = numsemaine, y = nbaccidentparsemaine)) +
    geom_line() +
        labs(title = "Répartition des accidents en fonction 
             des conditions atmosphériques", x = "Numéro de semaine", y = "Nombre d'accidents" ) +
        theme_minimal()
    print("On remarque que la distribution générale des 
    accidents dans le temps ne suit pas un modèle linéaire.
    Cependant, et justement car la variabilité des accidents 
    est grande entre deux intervalles de temps 
    (cela se remarque d'autant plus dans le cas
    des semaines, où les fluctuations
    de signe de la dérivée sont très nombreuses) 
    on peut estimer qu'un modèle linéaire
    conviendrait mieux à la
    distribution mensuelle des accidents.  ")
    print(figure4)
}
