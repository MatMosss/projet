BDD <- read.csv2(file = "stat_Ninho.csv")
BDD[BDD == "NULL"] <- " NA"
dim(BDD)
names(BDD)
summary(BDD)
head(BDD)
nombre <- dim(BDD)[1]
print(nombre)
counts <- unique(BDD$descr_athmo)

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

par(mfrow = c(1, 2)) #créer un tableau pour mettre les pie à coté
valeur <- fonction_visu(BDD$descr_athmo)

valeur1 <- valeur$list_nb
valeur2 <- valeur$list_type
pie(valeur1, labels = valeur2, main = "nb d'accident en fct des cdt athmo")
legend("topleft", legend = "sachant qu'en moyenne il pleut 15,2% du temps 
(24*365/576 où 576 est le nombre d'heure de pluie légère en moyenne 
en france en 2019) or 7296/73563*100 = 10% d'accident lié à la pluie legère
on ne peut en déduire que les accidents dépendent 
de conditions atmosphériques "
, bty = "n")
#bty supp le cadre autour de la légende sinon bug
surface <- fonction_visu(BDD$descr_etat_surf)
surf1 <- surface$list_nb
surf2 <- surface$list_type
print(surf1)
print(surf2)
pie(surf1, labels = surf2, main = "nb d'accident en fct de la surface")
legend("topleft", legend = "Ici on peut voir que sur sol mouillé, 
12250/73643*100 = 16,6% or il pleut en moyenne 15% du temps 
et la pluie peut mettre du temps à sécher, 
on ne peut pas conclure que les accidents sont lié à la surface"
, bty = "n")
print("Fin du code")
