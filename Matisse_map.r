# library(tmap)
# tmap_mode(mode = "view")
# library(rnaturalearth)
# france <- ne_states(country = "France", returnclass = "sf") %>% 
#   filter(!name %in% c("Guyane française", "Martinique", "Guadeloupe", "La Réunion", "Mayotte"))

# tm_shape(france) +
#   tm_polygons()

# library(tmap)
# tmap_mode(mode = "view")
# library(rnaturalearth)
# library(sf)
# library(dplyr)

# france <- ne_states(country = "France", returnclass = "sf") %>%
#   dplyr::filter(!name %in% c("Guyane française", "Martinique", "Guadeloupe", "La Réunion", "Mayotte"))

# map <- tm_shape(france) +
#   tm_polygons()

# print(map)
print("oui")