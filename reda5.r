install.packages(c("tidyverse","questionr"))
library(tidyverse)
library(questionr)
library(dplyr)
library(tidyverse)
library(questionr)

df <- read_delim("redol.csv", delim = ";")


freq_ville_new <- freq(df$descr_type_col, valid=FALSE,total=TRUE )

print(freq_ville_new,max = nrow(freq_ville_new))
df %>% select(descr_athmo) %>% table() 
df %>% select(descr_type_col) %>% table() 
df %>% select(descr_lum) %>% table() 
df %>% select(*) %>% table() 
