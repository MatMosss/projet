install.packages(c("tidyverse","questionr"))
library(tidyverse)
library(questionr)

df <- read_delim("redol.csv", delim = ";")

# Appliquer la fonction freq() à descr_type_col
freq_ville_new <- freq(df$descr_type_col, valid = FALSE, total = TRUE)
print(freq_ville_new, max = nrow(freq_ville_new))

# Sélection automatique des colonnes de type caractère ou facteur
colonnes <- df %>% select_if(function(col) {
  is.character(col) || is.factor(col)
})

# Appliquer la fonction table() à chaque colonne sélectionnée
resultats <- lapply(colonnes, table)

# Afficher les résultats
names(resultats) <- colnames(colonnes)
print(resultats)

# Calcul des tableaux de contingence
df_contingency <- do.call(rbind, lapply(df, table))
print(df_contingency)
