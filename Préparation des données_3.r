
data <- read.csv("stat_acc_V3.csv",header=TRUE, sep = ";")


dd=data$place


data$id_usa <- as.numeric(data$id_usa)
data$id_code_insee <- as.numeric(data$id_code_insee)
data$an_nais <- as.numeric(data$an_nais)
data$age <- as.numeric(data$age)
data$place <- as.numeric(data$place)

data$date <- as.Date(data$date)

gf=data$place


