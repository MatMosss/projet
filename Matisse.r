Data <- read.csv2(file = "stat_MossMoss.csv")

Data[Data == "NULL"] <- NA

# print(which(is.na(Data), arr.ind = TRUE))
print(sapply(Data,class))
Data$latitude <- as.numeric(Data$latitude)
Data$longitude <- as.numeric(Data$longitude)