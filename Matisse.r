data <- read.csv2(file = "stat_MossMoss.csv")
infos <- read.csv2(file = "cities.csv", sep = ",")
data[data == "NULL"] <- NA



data$latitude <- as.numeric(data$latitude)
data$longitude <- as.numeric(data$longitude)
data$an_nais <- as.numeric(data$an_nais)
data$age <- as.numeric(data$age)
data$id_code_insee <- as.numeric(data$id_code_insee)
# print(sapply(data,class))
# print(class(data$id_code_insee))

infos$insee_code <- as.numeric(infos$insee_code)
infos <- subset(infos, !duplicated(insee_code))

# compteur <- 1
# for (lat in data$latitude) {
#   if (lat == 2009 || lat == 0) {
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

print(class(data[908, "id_code_insee"]))
# print(data[data$latitude == 2009, ])
# print(which(is.na(data),arr.ind=TRUE))
# print(subset(infos, insee_code == 97414,longitude))