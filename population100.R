
population_100 <-function(){

    library(sqldf)
    library(dplyr)
  
    pop <- read.csv2(file = "donnees_regions.csv", sep = ";")
    pop$REG <- tolower(pop$REG)
    infos <- read.csv2(file = "cities.csv", sep = ",")


    df_groupe = sqldf("SELECT id_usa,data.descr_grav,infos.region_name, infos.department_name 
    FROM data 
    LEFT JOIN infos 
    ON data.id_code_insee = infos.insee_code")
    incident = sqldf("SELECT descr_grav,region_name,count(descr_grav) as count 
    FROM df_groupe 
    GROUP BY region_name,descr_grav")
    population = sqldf("SELECT descr_grav,region_name,PTOT,count FROM incident LEFT JOIN pop ON incident.region_name =  pop.REG")

    population <- cbind(population, pr_100000 = NA)

    population$count <- as.numeric(population$count)
    population$PTOT <- as.numeric(population$PTOT)
    population$pr_100000 = 100000*population$count/population$PTOT

    population$descr_grav[population$descr_grav == "Indemne"] <- 0
    population$descr_grav[population$descr_grav == "Blessé léger"] <- 1
    population$descr_grav[population$descr_grav == "Blessé hospitalisé"] <- 2
    population$descr_grav[population$descr_grav == "Tué"] <- 3

    listv = as.list(unique(population$region_name))
    v = 0;

    for (elt in listv){
        population$region_name[population$region_name==elt] <- v;
        v = v + 1 

    }
    population$descr_grav=as.numeric(population$descr_grav)
    population$region_name=as.numeric(population$region_name)

    return(population)
}

population2_100 <-function(){

    population = population_100()

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

    population2 = cbind(colonne0,colonne1,colonne2,colonne3)
    colnames(population2) <- c(0,1,2,3)
    rownames(population2) <- unique(population$region_name)

    # jeremy = read.csv2(file = "pop100.csv", sep = ",")
    # write.csv(jeremy, "pop100.csv",row.names = FALSE)


    return(population2)

}

ACP <-function(){

    population1 = population_100()
    PCA1 = PCA(population1)
    print(PCA1$eig)
    fviz_eig(PCA1)

    population2 = population2_100()
    PCA2 = PCA(population2)
    print(PCA2$eig)
    fviz_eig(PCA2)
}
