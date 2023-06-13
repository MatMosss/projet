data <- read.csv2('stat_Ninho.csv')

print(unique(data$descr_agglo))

i = 0;

for (elt in listi){
    data$descr_agglo[data$descr_agglo==elt] <- i;
    i = i + 1 

}

print(unique(data$descr_agglo))

print(unique(data$descr_cat_veh))

listj = as.list(unique(data$descr_cat_veh))
j = 0;

for (elt in listj){
    data$descr_cat_veh[data$descr_cat_veh==elt] <- j;
    j = j + 1 

}

print(unique(data$descr_cat_veh))

print(unique(data$descr_athmo))

listl = as.list(unique(data$descr_athmo))
l= 0 

for (elt in listl){
    data$descr_athmo[data$descr_athmo==elt] <- l;
    l = l + 1 

}

print(unique(data$descr_athmo))


print(unique(data$descr_lum))

listn = as.list(unique(data$descr_lum))
n =0

for (elt in listn){
    data$descr_lum[data$descr_lum==elt] <- n;
    n = n + 1 

}

print(unique(data$descr_lum))


print(unique(data$descr_grav))


data$descr_grav[data$descr_grav == "Indemne"] <- 0
data$descr_grav[data$descr_grav == "Blessé léger"] <- 1
data$descr_grav[data$descr_grav == "Blessé hospitalisé"] <- 2
data$descr_grav[data$descr_grav == "Tué"] <- 3

print(unique(data$descr_grav))


print(unique(data$descr_motif_traj))

listo = as.list(unique(data$descr_motif_traj))
o =0

for (elt in listo){
    data$descr_motif_traj[data$descr_motif_traj==elt] <- o;
    o = o + 1 

}

print(unique(data$descr_motif_traj))


