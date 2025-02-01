#!/bin/bash

# Vérifier si un argument a été passé
if [ -z "$1" ]; then
    echo "Veuillez spécifier un chemin vers un répertoire."
    exit 1
fi

# Vérifier si le chemin est un répertoire valide
if [ ! -d "$1" ]; then
    echo "Le chemin spécifié n'est pas un répertoire valide."
    exit 1
fi

# Lister les fichiers dans le répertoire (sans les sous-dossiers)
echo "Liste des fichiers dans le répertoire '$1' :"
find "$1" -maxdepth 1 -type f

