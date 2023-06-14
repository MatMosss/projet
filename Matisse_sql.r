library(sqldf)
library(dplyr)
vecteur1 <- c(1,1,1,3,3)
vecteur2 <- c(1,2,3) ; vecteur3 <- c("a","b","c")
vecteur2 <- data.frame(x = vecteur2, y = vecteur3) 
vecteur1 <- data.frame(id = vecteur1) 

data <- read.csv2(file = "stat_MossMoss.csv")
infos <- read.csv2(file = "cities.csv", sep = ",")
pop <- read.csv2(file = "donnees_regions.csv", sep = ";")

pop$REG <- tolower(pop$REG)
# insee = sqldf("SELECT * FROM vecteur1 LEFT JOIN vecteur2 ON vecteur1.id = vecteur2.x")
df_groupe = sqldf("SELECT data.descr_grav,infos.region_name FROM data LEFT JOIN infos ON data.id_code_insee = infos.insee_code")

incident = sqldf("SELECT descr_grav,region_name,count(descr_grav) as count FROM df_groupe GROUP BY region_name,descr_grav")

population = sqldf("SELECT descr_grav,region_name,PTOT,count FROM incident LEFT JOIN pop ON incident.region_name =  pop.REG")

population <- cbind(population, pr_100000 = NA)

population$count <- as.numeric(population$count)
population$PTOT <- as.numeric(population$PTOT)
population$pr_100000 = 100000*population$count/population$PTOT
# sqldf("UPDATE population SET pr_100000 = 100000*population.count/population.PTOT")
print(population)
