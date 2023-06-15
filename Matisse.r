library(maps)
library(ggplot2)
library(rmapshaper)
library(sf)


data <- read.csv2(file = "stat_MossMoss.csv")
infos <- read.csv2(file = "cities.csv", sep = ",")
data[data == "NULL"] <- NA



data$latitude <- as.numeric(data$latitude)
data$longitude <- as.numeric(data$longitude)
data$an_nais <- as.numeric(data$an_nais)
data$age <- as.numeric(data$age)
data$id_code_insee <- as.character(data$id_code_insee)
# print(sapply(data,class))
# print(class(data$id_code_insee))

infos$insee_code <- as.character(infos$insee_code)
infos <- subset(infos, !duplicated(insee_code))
 AGE - 14 !!!
# compteur <- 1
# for (lat in data$latitude) {
#   if (lat == 2009 || lat == "0") {
#     data[compteur, "longitude"] <- subset(infos, insee_code == data[compteur, "id_code_insee"], longitude)
#     data[compteur, "latitude"] <- subset(infos, insee_code == data[compteur, "id_code_insee"], latitude)
#   }
#   compteur <- compteur+1
# }
# compteur <- 1
# for (place in data$place) {
#   if (is.na(place)) {
#     data[compteur, "place"] <- 0
#   }
#   compteur <- compteur+1
# }
# data <- drop_na(data$an_nais)

# print(data[data$latitude == 2009, ])
# print(which(is.na(data),arr.ind=TRUE))
# print(subset(infos, insee_code == 97414,longitude))



# france_map <- map_data("france")
# print(
#   ggplot(data = france_map, aes(x = long, y = lat, group = group)) +
#   geom_polygon(fill = "gray", color = "black") +
#   coord_map() +
#   theme_void()
# )

# regions <- st_read("data/regions-20180101-shp/")
# regions1 <- ms_simplify(regions) #pour réduire le temp d'affichage de la carte
# index_hdf <- which(regions1$nom == "Bourgogne-Franche-Comté")
# print(ggplot() +
#   geom_sf(data = regions1) +
#   geom_sf(data = regions1[index_hdf, ], fill = "red") +
#   coord_sf(xlim = c(-5.5, 10), ylim = c(41, 51)) +
#   theme_void())


# data <- cbind(data, departement = NA, region = NA)
# compteur <- 1
# for (insee in data$id_code_insee) {
#   data$departement[compteur] <-  subset(infos, insee_code == insee,department_name )
#   data$region[compteur] <-  subset(infos, insee_code == insee,region_name )
#   print(compteur)
#   compteur <- compteur + 1
# }

# write.csv(data, "stat_MossMossV1.csv", row.names = FALSE)

# colnames(df)[colnames(df) == "ancien_nom"] <- "id_code_insee"

unique_data <- subset(infos, !duplicated(infos$region_name))
region_names <- head(unique_data$region_name, 13)
gravite <-unique(data$descr_grav)
df_regions <- data.frame(matrix(nrow = 4, ncol = 13))
colnames(df_regions) <- region_names
# print(table(data$descr_grav)[1]) 
# print(table(data$descr_grav)[1]) 

#infos$region_name[infos$insee_code == data$id_code_insee]

# for (region in colnames(df_regions)) {
# }
# data$id_code_insee <- as.numeric(data$id_code_insee)
# data <- drop_na(data$id_code_insee)
for (elt in unique(data$id_code_insee)){
    
}


# df_counts <- data.frame(insee = unique(data$id_code_insee), count_descr_grav_1 = 0)

# for (i in 1:nrow(df_counts)) {
#   insee_value <- df_counts$insee[i]
#   count_descr_grav_1 <- sum(data$descr_grav[data$insee == insee_value] == 1)
#   df_counts$count_descr_grav_1[i] <- count_descr_grav_1
# }
# print(df_counts)
