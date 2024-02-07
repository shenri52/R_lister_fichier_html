# Script R : lister_fichier_html

Ce script permet de lister le contenu d'une arborescence de dossiers et d'exporter le résultat sous forme d'un tableau html pour faciliter la recherche de fichier.
Il s'appuie sur une partie du script R lister_dossier.

## Descriptif du contenu

* Racine : emplacement du projet R --> "LISTER_FICHIER_HTML.Rproj"
* Un dossier "result" pour le stockage du résultat
* Un dosssier script qui contient :
  * prog_lister_fichier_html.R --> script principal
  * librairie.R --> script contenant les librairies utiles au programme
  * arborescence.R --> script permettant de lister le contenu d'une arborescence
  * tableau_html.R --> script permettant de créer un tableau html listant le contenu de l'arborescence
  * suppression_gitkeep.R --> script de suppression des .gitkeep

## Fonctionnement

1. Lancer le script intitulé "prog_lister_lister_fichier_html" qui se trouve dans le dossier "script"
2. Sélectionner le dossier à lister
3. Indiquer le nom de votre tableau
4. Indiquer le nom du fichier en sortie

## Résultat

Le tableau html sera exporter dans le dossier "result" et portera le nom que vous avez indiqué.
