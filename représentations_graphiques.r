library("ggplot2")
BDD <- read.csv2(file = "csv/stat_juju.csv")
#Modification dataframe
BDD[BDD == "NULL"] <- " NA"
BDD$descr_grav[BDD$descr_grav == "Indemne"] <- 0
BDD$descr_grav[BDD$descr_grav == "Blessé léger"] <- 1
BDD$descr_grav[BDD$descr_grav == "Blessé hospitalisé"] <- 2
BDD$descr_grav[BDD$descr_grav == "Tué"] <- 3
#fonction qui retourne le nombre d'occurrence pour chaque apparition de valeur
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
#stock diagramme camembert dans "figure/figureathmo.png"
affiche_pie_athmo <- function(){
    valeur <- fonction_visu(BDD$descr_athmo, 0)

    valeur1 <- valeur$list_nb
    valeur2 <- valeur$list_type
    dfathmo <- data.frame(valeur1 = valeur$list_nb, valeur2 = valeur$list_type)
    figure <- ggplot(data = dfathmo, aes(x = "", y = valeur1, fill = valeur2)) +
        geom_bar(stat = "identity", width = 1) +
        coord_polar(theta = "y") +
        labs(title = "Répartition des accidents en fonction des conditions atmosphériques",
        fill = "donnée athmosphérique",
    x = "", y="nb d'accident") +
        theme(plot.title = element_text(face = "bold", hjust=0.5))
    ggsave("figure/figureathmo.png", figure, dpi =300)
}

#stock diagramme camembert dans "figure/figuresurface.png"
affiche_pie_surface <- function(){
    surface <- fonction_visu(BDD$descr_etat_surf, 0)
    surf1 <- surface$list_nb
    surf2 <- surface$list_type
    dfathmo <- data.frame(surf1 = surface$list_nb, surf2 = surface$list_type)

    figure1 <- ggplot(data = dfathmo, aes(x = "", y = surf1, fill = surf2)) +
        geom_bar(stat = "identity", width = 1) +
        coord_polar(theta = "y") +
        labs(title = "Répartition des accidents en fonction de la surface",
        fill = "donnée surfacique",
    x = "", y="nb d'accident") +
        theme(plot.title = element_text(face = "bold", hjust=0.5))
    ggsave("figure/figuresurface.png", figure1, dpi =300)
    }

#stock diagramme barre dans "figure/figureville.png"
affiche_barre_ville <- function(){
    ville <- fonction_visu(BDD$ville, 0)
    ville1 <- ville$list_nb[ville$list_nb > 500]
    ville2 <- ville$list_type[ville$list_nb > 500]
    dfville <- data.frame(ville1, ville2)
    figure <- ggplot(dfville, aes(x = ville2, y = ville1, fill = ville2)) +
    geom_bar(stat = "identity") +
    labs(title = "Nombre d'accidents par ville",
         x = "Ville", y = "Nombre d'accidents") +
    theme(plot.title = element_text(face = "bold", hjust = 0.5)) +
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
    scale_fill_discrete()
    ggsave("figure/figureville.png", figure, dpi =300)

    }
#stocke diagramme barre dans "figure/figureheure.png"
affiche_pie_heure <- function(){
    date <- BDD$date
    listV <- c(0, 0, 0, 0, 0, 0)
    listV <- as.numeric(listV)
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
    dfheure$tranche_heure <- factor(dfheure$tranche_heure, levels = tranche_heure)
    figure2 <- ggplot(data = dfheure, aes(x = tranche_heure, y = listV, fill = tranche_heure)) +
        geom_bar(stat = "identity") +
    labs(title = "Nombre d'accidents par tranche horraire",
         x = "horraire", y = "Nombre d'accidents") +
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
    scale_fill_discrete()
    ggsave("figure/figureheure.png", figure2, dpi =300)

}

#stocke diagramme camembert dans "figure/figuregrav.png"
affiche_pie_gravite <- function(){
    gravite <- fonction_visu(BDD$descr_grav, 0)
    grav1 <- gravite$list_nb
    grav2 <- gravite$list_type
    dfgrav <- data.frame(grav1, grav2)
    gravite <- c("Indemne",  "Tué", "blessé hospitalisé", "blessé léger")
    figure1 <- ggplot(data = dfgrav, aes(x = "", y = grav1, fill = gravite)) +
        geom_bar(stat = "identity", width = 1) +
        coord_polar(theta = "y") +
        labs(title = "Répartition des accidents en fonction de la gravité",fill = "donnée gravité",
    x = "", y="nb d'accident") +
        theme(plot.title = element_text(face = "bold", hjust=0.5))
        ggsave("figure/figuregrav.png", figure1, dpi =300)

}
#créer un nouveau dataframe pour pouvoir manipuler les dates
ecriture_csv <- function(){
    listeVide = c()
    for(elt in BDD$date){
        mois <- substr(elt, start=6, stop=7)
        listeVide <- append(listeVide, mois)
    }
    BDD$mois <- listeVide

    BDD$date1 <- as.Date(BDD$date, format = "%Y-%m-%d %H:%M:%S")
    BDD$semaine <- format(BDD$date1, "%U")
    write.csv(BDD, "csv/stat_juju3.csv", row.names = FALSE)
}
BDD2 <- read.csv2(file = "csv/stat_juju3.csv", sep = ",")
#stocke série chronologique dans fichier/figureseriemoiscumul.png ou fichier/figureseriemois.png
affiche_serie_mois <- function(CUMUL){
    valeur1 <- fonction_visu(BDD2$mois, CUMUL)
    nbaccident <- valeur1$list_nb
    numois <- valeur1$list_type

    dictionnaire_mois <- c("Janvier", "Février", "Mars", "Avril", "Mai", "Juin", "Juillet", "Août", "Sept", "Octo", "Nov", "Déc")

    numois <- as.numeric(numois)
    dfmois = data.frame(nbaccident, numois)
    if(CUMUL== 0){
        figure7 <- ggplot(data = dfmois, aes(x = numois, y = nbaccident, fill = nbaccident)) +
        geom_line() +
        labs(title = "série chronologique des accidents en fonction des mois", x = "les mois", y = "Nombre d'accidents" ) +
        theme() +
        scale_x_continuous(breaks = numois, labels = dictionnaire_mois)
        ggsave("figure/figureseriemois.png", figure7, dpi =300)
    }
    if(CUMUL== 1){
        figure2 <- ggplot(data = dfmois, aes(x = numois, y = nbaccident, fill = nbaccident)) +
        geom_line() +labs(title = "série chronologique des accidents en fonction des mois cumulés", x = "les mois", y = "Nombre d'accidents" ) +
        theme() + scale_x_continuous(breaks = numois, labels = dictionnaire_mois)
        ggsave("figure/figureseriemoiscumul.png", figure2, dpi =300)
    }

 }
#stocke série chronologique dans fichier/figureseriesemainecumul.png ou fichier/figureseriesemaine.png
affiche_serie_semaine <- function(CUMUL){
    valeur2 <- fonction_visu(BDD2$semaine, CUMUL)  
    nbaccidentparsemaine <- valeur2$list_nb
    numsemaine <- valeur2$list_type
    numsemaine <- as.numeric(numsemaine)
    numsemaine <- sort(numsemaine)
    nbaccidentparsemaine <- nbaccidentparsemaine[order(numsemaine)]

    dfsemaine = data.frame(nbaccidentparsemaine, numsemaine)
    if(CUMUL== 0){
        figure4 <- ggplot(data = dfsemaine, aes(x = numsemaine, y = nbaccidentparsemaine)) +
        geom_line() +
        labs(title = "Série chrologique des accidents en fonction des semaines", x = "Numéro de semaine", y = "Nombre d'accidents" ) +
        theme()
        ggsave("figure/figureseriesemaine.png", figure4, dpi =300)
    }
    if(CUMUL== 1){
        figure8 <- ggplot(data = dfsemaine, aes(x = numsemaine, y = nbaccidentparsemaine)) +
        geom_line() +
        labs(title = "Série chrologique des accidents en fonction des semaines cumulés", x = "Numéro de semaine", y = "Nombre d'accidents" ) +
        theme()
        ggsave("figure/figureseriesemainecumul.png", figure8, dpi =300)
    }
}