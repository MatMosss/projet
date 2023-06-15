python -m pip install pandas
import pandas as pd
import matplotlib.pyplot as plt

# Charger le fichier CSV dans un DataFrame
df = pd.read_csv("redol.csv", sep=";")

# Extraire la colonne "descr_cat_veh"
descr_cat_veh_counts = df["descr_cat_veh"].value_counts()

# Créer un graphique en cercle
plt.pie(descr_cat_veh_counts, labels=descr_cat_veh_counts.index, autopct='%1.1f%%')
plt.axis('equal')  # Pour obtenir un cercle parfait

# Ajouter un titre
plt.title("Répartition des accidents par catégorie de véhicule")

# Afficher le graphique
plt.show()



