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

# Modification du format de la date
list_dossier$mtime <- as_date(list_dossier$mtime)
  
# Création d'un dataframe avec le nom du chemin, le nom du fichier et le type d'extension
list_dossier <- list_dossier %>%
                mutate(Chemin = dirname(row.names(list_dossier))) %>%
                mutate(Fichier = basename(row.names(list_dossier))) %>%
                mutate(Extension = as.factor(toupper(sub("^.+\\.", "", Fichier)))) %>%
                select(Chemin, Fichier, Extension, mtime)
  
# Suppression des noms de ligne
row.names(list_dossier) <- NULL
            