library(sqldf)
library(dplyr)
library(maps)
library(ggplot2)
library(rmapshaper)
library(sf)

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

nbr_incidents = sqldf("SELECT region_name, SUM(count) AS somme_count FROM population GROUP BY region_name;")

population <- cbind(population, pr_100000 = NA)

population$count <- as.numeric(population$count)
population$PTOT <- as.numeric(population$PTOT)
population$pr_100000 = 100000*population$count/population$PTOT
# print(nbr_incidents)



library(sf)
library(ggplot2)
library(stringr)
regions <- st_read("data/regions-20180101-shp/")
regions1 <- ms_simplify(regions) #pour réduire le temp d'affichage de la carte
format(object.size(regions1),units="Mb")
reg_arrang <- data.frame(tolower(regions1$nom))
colnames(reg_arrang)[1] <- c("region_name")
reg_arrang_join = sqldf("SELECT reg_arrang.region_name, nbr_incidents.somme_count FROM reg_arrang LEFT JOIN nbr_incidents ON reg_arrang.region_name = nbr_incidents.region_name")
reg_arrang_join[14, "somme_count"] <- 0
reg_arrang_join$somme_count <- as.integer(reg_arrang_join$somme_count)
# reg_arrang_join$region_name <- str_to_title(reg_arrang_join$region_name)

print(ggplot(regions1) +
  geom_sf(aes(fill = as.matrix(reg_arrang_join$somme_count))) +
  scale_fill_continuous(low="white",high="blue")+
  coord_sf(xlim = c(-5.5, 10), ylim = c(41, 51)) +
  theme_void())
