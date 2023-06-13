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

# regions <- read_sf("data/regions-20180101-shp/")
# library(rmapshaper)
# regions1 <- ms_simplify(regions)
# format(object.size(regions1),units="Mb")
# print(ggplot(regions1)+geom_sf()+
#   coord_sf(xlim = c(-5.5,10),ylim=c(41,51))+theme_void())



regions <- st_read("data/regions-20180101-shp/")

# Simplifier les données
regions1 <- ms_simplify(regions)

# Identifier l'index de la région des Hauts-de-France
index_hdf <- which(regions1$nom == "Bourgogne-Franche-Comté")

# Tracer la carte des régions simplifiées avec les Hauts-de-France en rouge
print(ggplot() +
  geom_sf(data = regions1) +
  geom_sf(data = regions1[index_hdf, ], fill = "red") +
  coord_sf(xlim = c(-5.5, 10), ylim = c(41, 51)) +
  theme_void())
