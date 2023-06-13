BDD <- read.csv2(file = "stat_Ninho.csv")
BDD[BDD == "NULL"] <- " NA"
dim(BDD)
names(BDD)
summary(BDD)
head(BDD)
nombre <- dim(BDD)[1]
print(nombre)
counts <- unique(BDD$descr_athmo)
BDD$descr_grav[BDD$descr_grav == "Indemne"] <- 0
BDD$descr_grav[BDD$descr_grav == "Blessé léger"] <- 1
BDD$descr_grav[BDD$descr_grav == "Blessé hospitalisé"] <- 2
BDD$descr_grav[BDD$descr_grav == "Tué"] <- 3
fonction_visu <- function(colonne){
    list_nb <- vector("numeric", 0)

    list_type <- vector("character", 0)
    compteur <- 0
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

#par(mfrow = c(1, 3)) #créer un tableau pour mettre les pie à coté
# valeur <- fonction_visu(BDD$descr_athmo)

# valeur1 <- valeur$list_nb
# valeur2 <- valeur$list_type
# #pie(valeur1, labels = valeur2, main = "nb d'accident en fct des cdt athmo")
# legend("topleft", legend = "sachant qu'en moyenne il pleut 15,2% du temps 
# (24*365/576 où 576 est le nombre d'heure de pluie légère en moyenne 
# en france en 2019) or 7296/73563*100 = 10% d'accident lié à la pluie legère
# on ne peut en déduire que les accidents dépendent 
# de conditions atmosphériques "
# , bty = "n")
# #bty supp le cadre autour de la légende sinon bug
# surface <- fonction_visu(BDD$descr_etat_surf)
# surf1 <- surface$list_nb
# surf2 <- surface$list_type

# #pie(surf1, labels = surf2, main = "nb d'accident en fct de la surface")
# legend("topleft", legend = "Ici on peut voir que sur sol mouillé, 
# 12250/73643*100 = 16,6% or il pleut en moyenne 15% du temps 
# et la pluie peut mettre du temps à sécher, 
# on ne peut pas conclure que les accidents sont lié à la surface"
# , bty = "n")
ville <- fonction_visu(BDD$ville)
ville1 <- ville$list_nb[ville$list_nb > 500]
ville2 <- ville$list_type[ville$list_nb > 500]
print(ville2)
print(ville1)
barplot(ville1, names.arg = ville2, main = "nb d'accident en fct de la ville",
xlab = "ville", ylab = "nb accident", las=2)
#las fait pivoter les noms du bas
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
#pie(listV, labels = tranche_heure, main = "nb d'accident en fct de l'heure")
#gravite <- fonction_visu(BDD$descr_grav)
#grav1 <- gravite$list_nb
#grav2 <- gravite$list_type

#pie(grav1, labels = grav2, main = "nb d'accident en fct de la gravité")
print("fin de code")