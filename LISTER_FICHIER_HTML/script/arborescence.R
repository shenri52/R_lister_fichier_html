#################### Lister le contenu d'une arborescence

# Afficher une boîte de dialogue pour indiquer le lecteur à analyser
lecteur <- NULL

while (is_empty(lecteur))
{
  lecteur <- dlg_dir(default = getwd(), title = "Choisir le dossier à analyser")$res
}

# Récupérer la liste des fichiers
list_dossier <- list.files(path = lecteur,
                           full.names = TRUE,
                           recursive = TRUE) %>%
                           # Récupérer la taille et la date de modification
                           file.info() %>%
                           select(mtime)

# Mettre en forme la liste des fichiers
list_dossier <- list_dossier %>%
                # Ajouter le chemin, le nom du fichier, l'extension et la date de modification formatée
                mutate(Chemin = dirname(row.names(list_dossier)),
                       Fichier = basename(row.names(list_dossier)),
                       Extension = as.factor(toupper(sub("^.+\\.", "", Fichier))),
                       mtime = as_date(list_dossier$mtime)) %>%
                # Choisir l'ordre des colonnes
                select(Chemin, Fichier, Extension, mtime)
  
# Supprimmer les noms de ligne
row.names(list_dossier) <- NULL
