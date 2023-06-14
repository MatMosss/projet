install.packages("rlang") 
install.packages('dplyr')
library(dplyr)

df <- read.csv("stat_acc_V3 (3).csv",sep=";")
df$age <- as.numeric(df$age)

df$nouvel_age <- df$age - 14

Donnee5<-select(df, nouvel_age)

head(Donnee5)
