data <- read.csv2(file = "stat_MossMoss.csv")
infos <- read.csv2(file = "cities.csv")
data[Data == "NULL"] <- NA



data$latitude <- as.numeric(data$latitude)
data$longitude <- as.numeric(data$longitude)
data$an_nais <- as.numeric(data$an_nais)
data$age <- as.numeric(data$age)
data$id_code_insee <- as.numeric(data$id_code_insee)
# print(sapply(data,class))
# print(class(data$id_code_insee))


print(data[data$latitude == 2009, ])
