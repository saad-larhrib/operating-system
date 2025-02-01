#!/bin/bash

# Étape 1 : Créer le fichier avec les étapes initiales (écrase le fichier existant s'il y en a un)
echo "1:250 g de farine." > recetteCrepes.txt
echo "2:4 oeufs." >> recetteCrepes.txt
echo "3:0,5 l de lait." >> recetteCrepes.txt
echo "5:50 g de beurre." >> recetteCrepes.txt
echo "6:1 sachet de sucre vanillé." >> recetteCrepes.txt
echo "4:1 pincée de sel." >> recetteCrepes.txt

# Étape 2 : Compter le nombre de lignes dans le fichier
echo "Nombre de lignes : $(wc -l < recetteCrepes.txt)"

# Étape 3 : Trier les lignes numériquement par le premier champ et sauvegarder dans un nouveau fichier
sort -n recetteCrepes.txt > recetteCrepes_sort.txt

# Vérifier le contenu trié
echo "Contenu trié :"
cat recetteCrepes_sort.txt

# Étape 4 : Supprimer les numéros et les deux-points au début de chaque ligne, afficher le résultat
echo "Contenu sans numéros :"
cut -d: -f2 recetteCrepes_sort.txt

# Étape 5 : Ajouter une 7ème étape au fichier original
echo "7:1 cuillère à soupe de miel (5 cl)" >> recetteCrepes.txt

# Étape 6 : Afficher toutes les lignes sauf celles contenant le mot "cuillère"
echo "Lignes sans 'cuillère' :"
grep -v "cuillère" recetteCrepes.txt

# Étape 7 : Afficher les trois dernières lignes du fichier
echo "Les 3 dernières lignes du fichier :"
tail -n 3 recetteCrepes.txt


# Etape 8 : Exécuter la commande cat pour afficher le contenu de RecetteTartes.txt
echo "Affichage de RecetteTartes.txt :"
cat RecetteTartes.txt

# Exécuter de nouveau la commande cat en redirigeant les erreurs
echo "Affichage de RecetteTartes.txt sans erreurs affichées :"
cat RecetteTartes.txt 2>/dev/null 

# Etape 9 : Regrouper les derniers commandes des deux dernieres question sur une soule linge 
tail -n 3 RecetteTartes; cat RecetteTartes.txt 2>/dev/null
