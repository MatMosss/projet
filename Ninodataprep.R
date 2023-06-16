require(FactoMineR)
library(sqldf)
library(dplyr)
library(factoextra)
library(ggplot2)
vecteur1 <- c(1,1,1,3,3)
vecteur2 <- c(1,2,3) ; vecteur3 <- c("a","b","c")
vecteur2 <- data.frame(x = vecteur2, y = vecteur3) 
vecteur1 <- data.frame(id = vecteur1) 

pop <- read.csv2(file = "csv/donnees_regions.csv", sep = ";")


pop$REG <- tolower(pop$REG)


population = sqldf("SELECT descr_grav,region_name,PTOT,count FROM incident LEFT JOIN pop ON incident.region_name =  pop.REG")

population <- cbind(population, pr_100000 = NA)

population$count <- as.numeric(population$count)
population$PTOT <- as.numeric(population$PTOT)
population$pr_100000 = 100000*population$count/population$PTOT

write.csv(population, "csv/pop100I.csv",row.names = FALSE)

print(population[1,1])

colonne0 = rep(0,17)
colonne1 = rep(0,17)
colonne2 = rep(0,17)
colonne3 = rep(0,17)



listv = as.list(unique(population$region_name))
v = 0;

for (elt in listv){
    population$region_name[population$region_name==elt] <- v;
    v = v + 1 

}

population$descr_grav[population$descr_grav == "Indemne"] <- 0
population$descr_grav[population$descr_grav == "Blessé léger"] <- 1
population$descr_grav[population$descr_grav == "Blessé hospitalisé"] <- 2
population$descr_grav[population$descr_grav == "Tué"] <- 3

print(population[6,5])
print(population$region_name[5])
for(i in 1:5){

    for(j in 1:68){

        if(i==1){

        switch(population[j,i], 

            "0"={
                colonne0[as.numeric(population$region_name[j]) + 1] = population[j,5]
            },
            "1"={
                colonne1[as.numeric(population$region_name[j]) + 1] = population[j,5]

            },
            "2"={
                colonne2[as.numeric(population$region_name[j]) + 1] = population[j,5]

            },
            "3"={
                colonne3[as.numeric(population$region_name[j]) + 1] = population[j,5]

            }

        )
        }

    }
}

print(colonne0)
print(colonne1)

matrice1 = cbind(colonne0,colonne1,colonne2,colonne3)
colnames(matrice1) <- c(0,1,2,3)
rownames(matrice1) <- unique(population$region_name)

print(matrice1)

write.csv(matrice1, "csv/pop100I.csv",row.names = FALSE)



PCA= PCA(matrice1)
print(PCA$eig)

layout(matrix(1:2,nrow=1))
plot(PCA, choix="ind", cex=0.7)
plot(PCA, choix="var")

print(barplot(PCA$eig[,2]))
print(fviz_eig(PCA,"eigenvalue","bar"))

population$descr_grav = as.numeric(population$descr_grav)
population$region_name = as.numeric(population$region_name)

PCA1 = prcomp(matrice1)
print(get_eig(PCA1))
print(fviz_eig(PCA1))


data <- read.csv2('csv/stat_Ninho.csv')
cities <- read.csv2('csv/cities.csv',sep = ",")

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



data$date<- as.Date(data$date,format="%Y-%m-%d %H:%M:%S")
data$mois<-format(data$date,"%m")
data$semaines <-format(data$date,"%U")

write.csv(data, "csv/stat_nino3.csv", row.names = FALSE)


BDD2 <- read.csv2(file = "csv/stat_nino3.csv", sep = ",")

valeur1 <- fonction_visu(BDD2$mois)
nbaccident <- as.numeric(valeur1$list_nb)
numois <- as.numeric(valeur1$list_type)

nbaccidentcumul <-rep(0,12)
nbaccidentcumul[1] = nbaccident[1]

for(i in 2:length(nbaccidentcumul)){

    nbaccidentcumul[i] = nbaccident[i]+nbaccidentcumul[i-1]

}
valeur2 <- fonction_visu(BDD2$semaines)
nbaccident2 <- as.numeric(valeur2$list_nb)
nusemaines <- as.numeric(valeur2$list_type)

nbaccidentcumul2 <-rep(0,53)
nbaccidentcumul2[1] = nbaccident2[1]
for(i in 2:length(nbaccidentcumul2)){

    nbaccidentcumul2[i] = nbaccident2[i]+nbaccidentcumul2[i-1]

}

model2 <- lm(nbaccident2 ~ nusemaines)
modelcumul2<-lm(nbaccidentcumul2~nusemaines)

print(summary(model2))
print(summary(model2)[2,1])

proportionVarMoisCumul = 5839194782/(5839194782+5450229)
proportionVarSCumul = 2.5933e+10/(2.5933e+10+3.0704e+08)

# 

ICmoisCumulB0 = c(-2351.39 - 1.96*454.37, -2351.39 + 1.96*454.37)
ICmoisCumulB1 = c(6390.11 - 1.96*61.74,6390.11 + 1.96*61.74)

ICsCumulB0 = c(-670.49 - 1.96*664.64,-670.49 + 1.96*664.64)
ICsCumulB1 = c(1446.05 - 1.96*22.03, 1446.05 + 1.96*22.03)


PCA = PCA(population)
