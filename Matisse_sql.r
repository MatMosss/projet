library(sqldf)
library(dplyr)
library(maps)
library(ggplot2)
library(rmapshaper)
library(sf)
library(stringr)




return_dataframe_for_print_graph <- function(){  
  data <- read.csv2(file = "stat_data.csv", sep = ",")
  infos <- read.csv2(file = "cities.csv", sep = ",")
  pop_reg <- read.csv2(file = "donnees_regions.csv", sep = ";")
  pop_dep <- read.csv2(file = "donnees_departements.csv", sep = ";")

  pop_reg$REG <- tolower(pop_reg$REG)
  df_groupe = sqldf("SELECT id_usa,data.descr_grav,infos.region_name, infos.department_name 
  FROM data 
  LEFT JOIN infos 
  ON data.id_code_insee = infos.insee_code")

  incident_reg = sqldf("SELECT descr_grav,region_name,count(descr_grav) as count 
  FROM df_groupe 
  GROUP BY region_name,descr_grav")
  incident_dep = sqldf("SELECT id_usa,descr_grav,department_name,count(descr_grav) as count 
  FROM df_groupe 
  GROUP BY department_name,descr_grav")
  incident_dep$descr_grav[incident_dep$descr_grav == "Indemne"] <- 0
  incident_dep$descr_grav[incident_dep$descr_grav == "Blessé léger"] <- 1
  incident_dep$descr_grav[incident_dep$descr_grav == "Blessé hospitalisé"] <- 2
  incident_dep$descr_grav[incident_dep$descr_grav == "Tué"] <- 3

  incident_reg$descr_grav[incident_reg$descr_grav == "Indemne"] <- 0
  incident_reg$descr_grav[incident_reg$descr_grav == "Blessé léger"] <- 1
  incident_reg$descr_grav[incident_reg$descr_grav == "Blessé hospitalisé"] <- 2
  incident_reg$descr_grav[incident_reg$descr_grav == "Tué"] <- 3
  # danger_dep <- sqldf("SELECT department_name, SUM(descr_grav*count)/SUM(count) as sum
  # FROM incident_dep
  # GROUP BY department_name;")
  danger_reg <- sqldf("SELECT region_name, 
                      CAST(SUM(descr_grav * count) AS REAL) / CAST(SUM(count) AS REAL) AS sum 
                      FROM incident_reg
                      GROUP BY region_name")
  danger_dep <- sqldf("SELECT department_name, 
                      CAST(SUM(descr_grav * count) AS REAL) / CAST(SUM(count) AS REAL) AS sum 
                      FROM incident_dep
                      GROUP BY department_name")

  population_reg = sqldf("SELECT incident_reg.descr_grav,incident_reg.region_name,pop_reg.PTOT,count 
  FROM incident_reg 
  LEFT JOIN pop_reg 
  ON incident_reg.region_name =  pop_reg.REG")
  population_reg <- cbind(population_reg, pr_100000 = NA)
  population_reg$count <- as.numeric(population_reg$count)
  population_reg$PTOT <- as.numeric(population_reg$PTOT)
  population_reg$pr_100000 <- 100000*population_reg$count/population_reg$PTOT

  population_dep = sqldf("SELECT incident_dep.descr_grav, incident_dep.department_name, pop_dep.PMUN, count
  FROM incident_dep
  LEFT JOIN pop_dep
  ON SUBSTR(incident_dep.id_usa, 1, 2) = SUBSTR(pop_dep.CODDEP, 1, 2)
    AND (SUBSTR(incident_dep.id_usa, 1, 2) <> '97' OR SUBSTR(incident_dep.id_usa, 1, 3) = SUBSTR(pop_dep.CODDEP, 1, 3))
  ")
  population_dep <- cbind(population_dep, pr_100000 = NA)
  population_dep$count <- as.numeric(population_dep$count)
  population_dep$PTOT <- as.numeric(population_dep$PMUN)
  population_dep$pr_100000 <- 100000*population_dep$count/population_dep$PMUN

  nbr_incidents_reg = sqldf("SELECT region_name, PTOT, pr_100000, SUM(count) AS somme_count 
  FROM population_reg 
  GROUP BY region_name")
  nbr_incidents_dep = sqldf("SELECT department_name, PMUN, pr_100000, SUM(count) AS somme_count 
  FROM population_dep 
  GROUP BY department_name")

  nbr_incidents_reg = sqldf("SELECT danger_reg.sum,nbr_incidents_reg.region_name, nbr_incidents_reg.PTOT, nbr_incidents_reg.pr_100000,nbr_incidents_reg.somme_count  
  FROM nbr_incidents_reg JOIN danger_reg 
  ON nbr_incidents_reg.region_name = danger_reg.region_name")
  nbr_incidents_dep = sqldf("SELECT danger_dep.sum,nbr_incidents_dep.department_name, nbr_incidents_dep.PMUN, nbr_incidents_dep.pr_100000,nbr_incidents_dep.somme_count  
  FROM nbr_incidents_dep JOIN danger_dep 
  ON nbr_incidents_dep.department_name = danger_dep.department_name")
  nbr_incidents_dep$sum <- as.numeric(nbr_incidents_dep$sum )

return(list(nbr_incidents_reg = nbr_incidents_reg, nbr_incidents_dep = nbr_incidents_dep))
}


download_graph_regions <- function(type_graph){
  nbr_incidents <- return_dataframe_for_print_graph()
  nbr_incidents_reg <- nbr_incidents$nbr_incidents_reg


  regions <- st_read("data/regions-20180101-shp/")
  regions1 <- ms_simplify(regions) #pour réduire le temp d'affichage de la carte
  format(object.size(regions1),units="Mb")
  reg_arrang <- data.frame(tolower(regions1$nom))
  colnames(reg_arrang)[1] <- c("region_name")
  reg_arrang_join = sqldf("SELECT reg_arrang.region_name,nbr_incidents_reg.sum ,nbr_incidents_reg.pr_100000, nbr_incidents_reg.somme_count FROM reg_arrang LEFT JOIN nbr_incidents_reg ON reg_arrang.region_name = nbr_incidents_reg.region_name")
  reg_arrang_join[14, "somme_count"] <- 0
  reg_arrang_join$somme_count <- as.integer(reg_arrang_join$somme_count)
  # reg_arrang_join$region_name <- str_to_title(reg_arrang_join$region_name)

    if(type_graph == "pr_100000"){
      dataframe <- reg_arrang_join$pr_100000
    title <- "Nombre d'accidents par région pour 100000 habitants"
    legende <- "Nombre d'accidents"
    }
    else if (type_graph == "somme_accident") {
      dataframe <- reg_arrang_join$somme_count
    title <- "Nombre accidents par région"
    legende <- "Nombre d'accidents"
    }
    else if (type_graph == "dangerosite") {
      dataframe <- reg_arrang_join$sum
    title <- "Niveau de gravité par région"
    legende <- "3 = Tué\n2 = hospitalisé\n1 = blessé léger\n0 = indemne"
    }

  plot <- graph_nbr_incident <- ggplot(regions1) +
    geom_sf(aes(fill = as.matrix(dataframe))) +
    scale_fill_continuous(low="white",high="blue")+
    coord_sf(xlim = c(-5.5, 10), ylim = c(41, 51)) +
    theme_void()+
    labs(title = title)+
    labs(fill = legende) +
    theme(
      plot.title = element_text(face = "bold", hjust = 0.5, size = 14, color = "white"),
    legend.text = element_text(color = "white"),
    legend.title = element_text(color = "white")
    )
  name1 <- "png/graphique_region_"
  name2 <- as.character(type_graph)
  name3 <- ".png"
  path = paste(name1, name2, name3)
  ggsave(path, plot = plot, device = "png")
  print(nbr_incidents_reg)
}  





download_graph_departement <- function(type_graph){
  nbr_incidents <- return_dataframe_for_print_graph()
  nbr_incidents_dep <- nbr_incidents$nbr_incidents_dep

  france_map <- map_data("france")
  france_map$region <- gsub("-", " ", france_map$region)
  france_map$region <- gsub("'", "", france_map$region)
  nbr_incidents_dep$department_name <- gsub("-", " ", nbr_incidents_dep$department_name)
  nbr_incidents_dep$department_name <- gsub("'", "", nbr_incidents_dep$department_name)

  dep_arrang <- data.frame(tolower(france_map$region))
  colnames(dep_arrang)[1] <- c("department_name")
  nbr_incidents_dep$department_name <- iconv(nbr_incidents_dep$department_name, to = "ASCII//TRANSLIT")
  dep_arrang_join = sqldf("SELECT dep_arrang.department_name, nbr_incidents_dep.pr_100000, nbr_incidents_dep.sum , nbr_incidents_dep.somme_count FROM dep_arrang LEFT JOIN nbr_incidents_dep ON dep_arrang.department_name = nbr_incidents_dep.department_name")

  if(type_graph == "pr_100000"){
    dataframe <- dep_arrang_join$pr_100000
    title <- "Nombre d'accidents par département pour 100000 habitants"
    legende <- "Nombre d'accidents"
  }
  else if (type_graph == "somme_accident") {
    dataframe <- dep_arrang_join$somme_count
    title <- "Nombre accidents par département"
    legende <- "Nombre d'accidents"
  }
  else if (type_graph == "dangerosite") {
    dataframe <- dep_arrang_join$sum
    title <- "Niveau de gravité par département"
    legende <- "3 = Tué\n2 = hospitalisé\n1 = blessé léger\n0 = indemne"
  }
  
  plot <- ggplot(data = france_map, aes(x = long, y = lat, group = group, fill = dataframe)) +
  geom_polygon(color = "black") +
  scale_fill_continuous(low = "white", high = "blue", na.value = "white") +
  coord_map() +
  theme_void() +
  labs(title = title ) +
  labs(fill = legende) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5, size = 14, color = "white"),
    legend.text = element_text(color = "white"),
    legend.title = element_text(color = "white")

  )
  name1 <- "png/graphique_departement_"
  name2 <- as.character(type_graph)
  name3 <- ".png"
  path = paste(name1, name2, name3)
  ggsave(path, plot = plot, device = "png")
}

download_graph_regions("dangerosite")
download_graph_regions("somme_accident")
download_graph_regions("pr_100000")

download_graph_departement("dangerosite")
download_graph_departement("somme_accident")
download_graph_departement("pr_100000")

download_graph_regions("somme_accident")
