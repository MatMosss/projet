
BDD <- read.csv2(file = "stat_juju.csv")

dim(BDD)
names(BDD)
summary(BDD)
head(BDD)
nombre <- dim(BDD)[1]
print(nombre)

counts <- table(BDD$descr_athmo)

print(counts)


print("Fin du code")
