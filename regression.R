#Cette fonction permet de retourner (pour notre usage) les mois/semaines
# et leur nombre d'accidents correspondants

fonction_visu1 <- function(colonne){
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

regressions <-function(){

    data =read.csv2('csv/stat_juju.csv')

    data$date<- as.Date(data$date,format="%Y-%m-%d %H:%M:%S")
    data$mois<-format(data$date,"%m")
    data$semaines <-format(data$date,"%U")

    write.csv(data, "csv/temp.csv", row.names = FALSE)


    BDD2 <- read.csv2(file = "csv/temp.csv", sep = ",")

    #Utilisation de fonction_visu() pour avoir les mois et leur nombre d'accidents correspondants
    valeur1 <- fonction_visu1(BDD2$mois)
    nbaccident <- as.numeric(valeur1$list_nb)
    numois <- as.numeric(valeur1$list_type)

    #Nombre d'accidents correspondants pour les modèles cumulatifs
    nbaccidentcumul <-rep(0,12)
    nbaccidentcumul[1] = nbaccident[1]

    for(i in 2:length(nbaccidentcumul)){

        nbaccidentcumul[i] = nbaccident[i]+nbaccidentcumul[i-1]

    }

    #Création des modèles de régression linéaire
    model <- lm(nbaccident ~ numois)
    modelcumul<-lm(nbaccidentcumul~numois)

    par(mfrow=c(1,4))

    plot(numois,nbaccident, col = "blue",title("Accidents en fonction 
    des mois"))
    abline(lm(nbaccident ~ numois))

    plot(numois,nbaccidentcumul, col = "red",title("Accidents cumulés en fonction
     des mois"))
    abline(lm(nbaccidentcumul ~ numois))
    
    #Affiche de nombreuses informations statistiques 
    print(summary(model))
    print(anova(model))

    print(summary(modelcumul))
    print(anova(modelcumul))

    #Réitère le processus pour les semaines
    valeur2 <- fonction_visu1(BDD2$semaines)
    nbaccident2 <- as.numeric(valeur2$list_nb)
    nusemaines <- as.numeric(valeur2$list_type)

    nbaccidentcumul2 <-rep(0,53)
    nbaccidentcumul2[1] = nbaccident2[1]
    for(i in 2:length(nbaccidentcumul2)){

        nbaccidentcumul2[i] = nbaccident2[i]+nbaccidentcumul2[i-1]

    }

    model2 <- lm(nbaccident2 ~ nusemaines)
    modelcumul2<-lm(nbaccidentcumul2~nusemaines)

    plot(nusemaines,nbaccident2,col ="blue",title("Accidents en fonction
     des semaines"))
    abline(lm(nbaccident2 ~ nusemaines))
    print(summary(model2))
    print(anova(model2))

    plot(nusemaines,nbaccidentcumul2, col = "red",title("Accidents cumulés en fonction
     des semaines"))
    abline(lm(nbaccidentcumul2 ~ nusemaines))
    print(summary(modelcumul2))
    print(anova(modelcumul2))

    proportionVarMois = 501389/(501389+5465454)
    proportionVarS = 103891/(103891+3317633)

    proportionVarMoisCumul = 5839194782/(5839194782+5450229)
    proportionVarSCumul = 2.5933e+10/(2.5933e+10+3.0704e+08)

    ICmoisB0 = c(5752.03 - 455.00*1.96,5752.03 + 455.00*1.96)
    ICmoisB1 = c(59.21-61.82*1.96,59.21+61.82*1.96)

    ICmoisCumulB0 = c(-2351.39 - 1.96*454.37, -2351.39 + 1.96*454.37)
    ICmoisCumulB1 = c(6390.11 - 1.96*61.74,6390.11 + 1.96*61.74)

    ICsB0 = c(1314.239 - 69.088*1.96,1314.239 + 69.088*1.96)
    ICsB1 = c(2.894-2.290*1.96,2.894+2.290*1.96)

    ICsCumulB0 = c(-670.49 - 1.96*664.64,-670.49 + 1.96*664.64)
    ICsCumulB1 = c(1446.05 - 1.96*22.03, 1446.05 + 1.96*22.03)

}
