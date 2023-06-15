library(maps)
library(ggplot2)
library(rmapshaper)
library(sf)

# regions <- st_read("data/regions-20180101-shp/")
# regions1 <- ms_simplify(regions) #pour réduire le temp d'affichage de la carte
# print(ggplot() +
#   geom_sf(data = regions1, aes(fill = population$pr_100000.as_matrix)) +
#   # geom_sf(aes(fill = population$pr_100000.as_matrix)) +
#   scale_fill_continuous(low="white",high="blue")+
#   coord_sf(xlim = c(-5.5, 10), ylim = c(41, 51)) +
#   theme_void())

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

# print(ggplot(regions1) +
#   geom_sf(aes(fill = as.matrix(reg_arrang_join$somme_count))) +
#   scale_fill_continuous(low="white",high="blue")+
#   coord_sf(xlim = c(-5.5, 10), ylim = c(41, 51)) +
#   theme_void())

france_map <- map_data("france")
print(
  ggplot(data = france_map, aes(x = long, y = lat, group = group)) +
  geom_polygon(fill = "gray", color = "black") +
  coord_map() +
  theme_void()
)
