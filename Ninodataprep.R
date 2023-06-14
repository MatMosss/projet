require(FactoMineR)

data <- read.csv2('stat_Ninho.csv')
cities <- read.csv2('cities.csv',sep = ",")

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

# print(unique(data$descr_agglo))


# data$descr_agglo[data$descr_agglo == "Hors agglomération"] <- 0
# data$descr_agglo[data$descr_agglo == "En agglomération"] <- 1

# print(unique(data$descr_agglo))

# print(unique(data$descr_cat_veh))

# listj = as.list(unique(data$descr_cat_veh))
# j = 0;

# for (elt in listj){
#     data$descr_cat_veh[data$descr_cat_veh==elt] <- j;
#     j = j + 1 

# }

# print(unique(data$descr_cat_veh))

# print(unique(data$descr_athmo))

# listl = as.list(unique(data$descr_athmo))
# l= 0 

# for (elt in listl){
#     data$descr_athmo[data$descr_athmo==elt] <- l;
#     l = l + 1 

# }

# print(unique(data$descr_athmo))


# print(unique(data$descr_lum))

# listn = as.list(unique(data$descr_lum))
# n =0

# for (elt in listn){
#     data$descr_lum[data$descr_lum==elt] <- n;
#     n = n + 1 

# }

# print(unique(data$descr_lum))

# data$descr_lum[data$descr_lum == "Plein jour"] <- 0
# data$descr_lum[data$descr_lum == "Crépuscule ou aube"] <- 1
# data$descr_lum[data$descr_lum == "Nuit avec éclairage public allumé"] <- 2
# data$descr_lum[data$descr_lum == "Nuit avec éclairage public non allumé"] <- 3
# data$descr_lum[data$descr_lum == "Nuit sans éclairage public"] <- 4



# print(unique(data$descr_grav))


# data$descr_grav[data$descr_grav == "Indemne"] <- 0
# data$descr_grav[data$descr_grav == "Blessé léger"] <- 1
# data$descr_grav[data$descr_grav == "Blessé hospitalisé"] <- 2
# data$descr_grav[data$descr_grav == "Tué"] <- 3

# print(unique(data$descr_grav))


# print(unique(data$descr_motif_traj))

# listo = as.list(unique(data$descr_motif_traj))
# o =0

# for (elt in listo){
#     data$descr_motif_traj[data$descr_motif_traj==elt] <- o;
#     o = o + 1 

# }

# print(unique(data$descr_motif_traj))



# 974 976 973 972 971
#table()

test<-c("ST GENIX LES VILLAGES","PANNECE","PIPRIAC")
inhabitantstest<-c(15,2,2,5,14,6555,53,652,9864,6526,98485,565,9865)
inhabitants <-c(8197325,2786296,3429882,2572278,351255,5562262,5980697,12358932,3317023,6110365,6101005,3907426,5160091)
regions<-c("Auvergne-Rhône-Alpes","Bourgogne- Franche-Comté","Bretagne","Centre - Val de Loire","Corse","Grand Est","Hauts-de-France","Île-de-France","Normandie","Nouvelle Aquitaine","Occitanie","Pays de la Loire","Provence-Alpes-Côte d’Azur")
regions <- unique(cities$region_geojson_name)
score<-c(0,0,0,0,0,0,0,0,0,0,0,0,0)
# gravite<-c([],[],[],[])
scoreRectifie<-c(0,0,0,0,0,0,0,0,0,0,0,0,0)
names(cities)[1]<-"id_code_insee"

# merge(data,cities,by = "id_code_insee")

# print(table(data[2,5]))

# if (cities$id_code_insee == data$id_code_insee){

#     colregion
# }

# for(reg in data$ville){

#     for(g in data$descr_grav){

#         for(region in test){

#             place = 1
#             while(region!=test[place]){

#                 place = place +1
#             }

#             if(reg==region){

#                 score[place] = score[place]+1

#                 print(score[1])
#                 print(score[2])
#                 print(score[3])

#                 print("oui")
#             }
    
#         }
        
#     }

# }

# for(i in 1:13){      

#     scoreRectifie[i] = (100000*score[i])/inhabitantstest[i]

# }

# print(scoreRectifie)


# for(i in 1:length(data$id_code_insee)){

#     print(round(as.numeric(data$id_code_insee[i])/10000,0))
#     print(i)

#     if(round(as.numeric(data$id_code_insee[i])/1000,0) == 97){

#         print(data$ville[i])
#         rm(e)

#     }
# }



data$date<- as.Date(data$date,format="%Y-%m-%d %H:%M:%S")
data$mois<-format(data$date,"%m")
data$semaines <-format(data$date,"%U")

write.csv(data, "stat_nino3.csv", row.names = FALSE)


BDD2 <- read.csv2(file = "stat_nino3.csv", sep = ",")

valeur1 <- fonction_visu(BDD2$mois)
nbaccident <- as.numeric(valeur1$list_nb)
numois <- as.numeric(valeur1$list_type)

nbaccidentcumul <-rep(0,12)
nbaccidentcumul[1] = nbaccident[1]

for(i in 2:length(nbaccidentcumul)){

    nbaccidentcumul[i] = nbaccident[i]+nbaccidentcumul[i-1]

}
# print(nbaccident)
# print(nbaccidentcumul)
# print(numois)
# model <- lm(nbaccident ~ numois)
# modelcumul<-lm(nbaccidentcumul~numois)
# plot(numois,nbaccidentcumul)

# plot(numois,nbaccident, col = "blue")
# abline(lm(nbaccident ~ numois))
# print(summary(model))
# print(anova(model))

# print(summary(modelcumul))
# print(anova(modelcumul))

# plot(numois,nbaccidentcumul, col = "red")
# abline(lm(nbaccidentcumul ~ numois))

valeur2 <- fonction_visu(BDD2$semaines)
nbaccident2 <- as.numeric(valeur2$list_nb)
nusemaines <- as.numeric(valeur2$list_type)

nbaccidentcumul2 <-rep(0,53)
nbaccidentcumul2[1] = nbaccident2[1]
for(i in 2:length(nbaccidentcumul2)){

    nbaccidentcumul2[i] = nbaccident2[i]+nbaccidentcumul2[i-1]

}
# print(nbaccidentcumul2)
# print(nbaccident2)
# print(nusemaines)
model2 <- lm(nbaccident2 ~ nusemaines)
modelcumul2<-lm(nbaccidentcumul2~nusemaines)

# plot(nusemaines,nbaccidentcumul2)
# plot(nusemaines,nbaccident2)
# abline(lm(nbaccident2 ~ nusemaines))
# print(summary(model2))
# print(anova(model2))

print(summary(modelcumul2))
print(anova(modelcumul2))

# plot(nusemaines,nbaccidentcumul2, col = "red")
# abline(lm(nbaccidentcumul2 ~ nusemaines))


# proportionVarMois = 501389/(501389+5465454)
# proportionVarS = 103891/(103891+3317633)

proportionVarMoisCumul = 5839194782/(5839194782+5450229)
proportionVarSCumul = 2.5933e+10/(2.5933e+10+3.0704e+08)

print(proportionVarMoisCumul)
print(proportionVarSCumul)

# print(proportionVarMois)
# print(proportionVarS)

# ICmoisB0 = c(5752.03 - 455.00*1.96,5752.03 + 455.00*1.96)
# ICsB0 = c(1314.239 - 69.088*1.96,1314.239 + 69.088*1.96)

# ICmoisB1 = c(59.21-61.82*1.96,59.21+61.82*1.96)
# ICsB1 = c(2.894-2.290*1.96,2.894+2.290*1.96)

ICmoisCumulB0 = c(-2351.39 - 1.96*454.37, -2351.39 + 1.96*454.37)
ICmoisCumulB1 = c(6390.11 - 1.96*61.74,6390.11 + 1.96*61.74)

ICsCumulB0 = c(-670.49 - 1.96*664.64,-670.49 + 1.96*664.64)
ICsCumulB1 = c(1446.05 - 1.96*22.03, 1446.05 + 1.96*22.03)

print(ICmoisCumulB0)
print(ICmoisCumulB1)

print(ICsCumulB0)
print(ICsCumulB1)

# print(ICmoisB0)
# print(ICmoisB1)

# print(ICsB0)
# print(ICsB1)


# valeur3 <- fonction_visu(BDD2$descr_athmo)
# nbaccident3 <- as.numeric(valeur3$list_nb)
# nuathmo <- as.numeric(valeur3$list_type)
# model3 = lm(nbaccident3~nuathmo)
# plot(nuathmo,nbaccident3)
# print(summary(model3))
# print(anova(model3))

# proportionVarAthmo = 30238900/(30238900+2975451892)
# print(proportionVarAthmo)

# valeur4 <- fonction_visu(BDD2$descr_lum)
# nbaccident4 <- as.numeric(valeur4$list_nb)
# nulum <- as.numeric(valeur4$list_type)
# model4 = lm(nbaccident4~nulum)
# plot(nulum,nbaccident4)
# print(summary(model4))
# print(anova(model4))

# valeurs = rep(0,length(colnames(data)))
# nbaccidents = rep(0,length(colnames(data)))
# nus = rep(0,length(colnames(data)))
# models= rep(0,length(colnames(data)))

# print(colnames(BDD2)[1])
# print(BDD2$colnames(BDD2)[1])

# for(i in 1:length(colnames(BDD2))){

#     valeurs[i] <- fonction_visu(BDD2$colnames(BDD2)[i])
#     nbaccident[i] <- as.numeric(valeur[i]$list_nb)
#     nus[i] <- as.numeric(valeur[i]$list_type)
#     model[i] = lm(nbaccident[i]~nus[i])

# }

# moisRSS = 0
# for(i in 1:length(valeur1$list_nb)){

#         moisRSS = moisRSS + (valeur1$list_nb[i] - (5752.03 + i*59.21))**2

# }

# print(moisRSS)

moisCumulSCE = 0
for(i in 1:length(nbaccidentcumul)){

        moisCumulSCE = moisCumulSCE + (mean(nbaccidentcumul[i]) - (6390.11 + i*61.74))**2

}

moisCumulSCT = 0
for(i in 1:length(nbaccidentcumul)){

        moisCumulSCT = moisCumulSCT + (mean(nbaccidentcumul[i]) - nbaccidentcumul[i])**2

}

moisCumulR2 = moisCumulSCE/moisCumulSCT
print(moisCumulR2)

sCumulSCE = 0
for(i in 1:length(nbaccidentcumul2)){

        moisCumulSCE = moisCumulSCE + (mean(nbaccidentcumul[i]) - 1446.05 + i*22.03)**2

}
# moisTSS = 0
# for(i in 1:length(valeur1$list_nb)){

#         moisTSS = moisTSS + (valeur1$list_nb[i] - mean(valeur1$list_nb))**2

# }
# # moisTSS = moisTSS/length(valeur1$list_nb)
# print(moisTSS)

# moisSCE = 0
# for(i in 1:length(valeur1$list_nb)){

#         moisSCE = moisSCE + ((5752.03 + i*59.21) - mean(valeur1$list_nb))**2

# }

# moisR2 = 1 - (moisRSS/moisTSS)
# print(moisR2)

# moisR2 = moisSCE/moisTSS
# print(moisR2)

# print("  n   ")


# sRSS = 0
# for(i in 1:length(valeur2$list_nb)){

#         sRSS = sRSS + (valeur2$list_nb[i] - (1314.239 + i*2.894))**2

# }

# print(sRSS)

# sTSS = 0
# for(i in 1:length(valeur2$list_nb)){

#         sTSS = sTSS + (valeur2$list_nb[i] - mean(valeur2$list_nb))**2

# }
# # moisTSS = moisTSS/length(valeur1$list_nb)
# print(sTSS)

# sSCE = 0
# for(i in 1:length(valeur2$list_nb)){

#         sSCE = sSCE + ((1314.239 + i*2.894) - mean(valeur2$list_nb))**2

# }

# sR2 = 1 - (sRSS/sTSS)
# print(sR2)

# sR2 = sSCE/sTSS
# print(sR2)



# PCA = PCA(data)