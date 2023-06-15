    recodage<-function(data){

        data$descr_agglo[data$descr_agglo == "Hors agglomération"] <- 0
        data$descr_agglo[data$descr_agglo == "En agglomération"] <- 1

        listj = as.list(unique(data$descr_cat_veh))
        j = 0;

         for (elt in listj){
            data$descr_cat_veh[data$descr_cat_veh==elt] <- j;
            j = j + 1 

        }

        listl = as.list(unique(data$descr_athmo))
        l= 0 

        for (elt in listl){
            data$descr_athmo[data$descr_athmo==elt] <- l;
            l = l + 1 

        }  
        listn = as.list(unique(data$descr_lum))
        n =0

        for (elt in listn){
            data$descr_lum[data$descr_lum==elt] <- n;
            n = n + 1 

        }

        data$descr_lum[data$descr_lum == "Plein jour"] <- 0
        data$descr_lum[data$descr_lum == "Crépuscule ou aube"] <- 1
        data$descr_lum[data$descr_lum == "Nuit avec éclairage public allumé"] <- 2
        data$descr_lum[data$descr_lum == "Nuit avec éclairage public non allumé"] <- 3
        data$descr_lum[data$descr_lum == "Nuit sans éclairage public"] <- 4

        data$descr_grav[data$descr_grav == "Indemne"] <- 0
        data$descr_grav[data$descr_grav == "Blessé léger"] <- 1
        data$descr_grav[data$descr_grav == "Blessé hospitalisé"] <- 2
        data$descr_grav[data$descr_grav == "Tué"] <- 3

        listo = as.list(unique(data$descr_motif_traj))
        o =0

        for (elt in listo){
            data$descr_motif_traj[data$descr_motif_traj==elt] <- o;
            o = o + 1 

        }

        
    }

