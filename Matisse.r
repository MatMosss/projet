Data <- read.csv2(file = "stat_MossMoss.csv")
# print(Data$date)
# print(which(is.na(Data),arr.ind=TRUE))
# print(summary(Data))
# read.csv(text=bt, na.string = "abc")
Data[Data == "NULL"] <- NA
# print(is.na(Data))
print(which(is.na(Data),arr.ind=TRUE))
