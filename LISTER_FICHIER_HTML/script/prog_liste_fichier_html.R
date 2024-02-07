#######################################################################
# Ce script a pour de produire un tableau au format HTML              #
# de l'arborescence d'un dossier pour faciliter la recherche de       #
# fichier                                                             #
#######################################################################
# Fonctionnement :                                                    #
#     1 - création de la liste des fichiers et de leur emplacement    #
#     2 - création d'un tableau html                                  #
#                                                                     #
# Résultat :                                                          #
# Un fichier html avec plusieurs options de filtrage et un lien vers  #
# le fichier                                                          #
#######################################################################


#################### Chargement des librairies

source("script/librairie.R")


#################### Suppression des fichiers gitkeep

source("script/suppression_gitkeep.R")

#################### Lister le contenu de l'arborescence

source("script/arborescence.R")

#################### Création du tableau html

source("script/tableau_html.R")
