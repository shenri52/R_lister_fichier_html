#################### Tableau html

# Définir le nom du tableau
tab_html_nom <- NULL

while (is_empty(tab_html_nom))
{
  tab_html_nom <- dlgInput("Saisir le nom du tableau", default = "Index de la cartothèque")$res  
}

# Définir le nom du fichier
fichier_html_nom <- NULL

while (is_empty(fichier_html_nom))
{
  fichier_html_nom <- dlgInput("Saisir le nom du fichier", default = "index_cartotheque")$res  
}

# Préparation du tableau html
tab_html <- list_dossier %>%
            # 1 - Suppression du lecteur (chemin) et du / qui le suit
            # 2 - Suppression du texte après le premier / qui contient les autres dossiers
            mutate(Theme = sub("/\\^*.*", "", str_remove_all(Chemin, paste(lecteur, "/", sep = "")))) %>%
            mutate(Fichier = substr(Fichier, 1, (nchar(Fichier)-nchar(as.character(Extension))-1))) %>%
            # Pour faire face à un bug sur cette 2eme date, le nom attendu dans la datatatble 
            # Cette colonne est utilisée pour le searchPanes puis masquée
            # Bug non rencontré avec les autres colonnes
            mutate(Période = substr(as.character(mtime), 1, 7)) %>%
            # Création d'un lien hypertexte vers le dossier
            mutate (LIEN = sprintf('<a href = "file://%s" target ="_blank">%s</a>', Chemin, "Lien"))%>%
            # Choix de l'ordre des colonnes
            select(Theme, Chemin, Fichier, Extension, mtime, Période, LIEN)

# Mise en forme du tableau html
tab_html <- tab_html %>%
            datatable(
                      # Suppression d'un nom des lignes
                      rownames = FALSE,
                      # Extensions : sélection, volet de recherche et boutons
                      extensions = c("Select", "SearchPanes", "Buttons"), 
                      selection = "none",
                      # Echappement du code html du lien
                      escape = c(6),
                      # Bordure colonne/ligne
                      class = "hover cell-border stripe",
                      # Fonctions de recherche
                      filter = list(position = "top", clear = TRUE),
                      #Nommage tableau
                      caption = tags$caption(style="caption-side: center; text-align: center; font-weight: bold; margin: 30px 0; background-color: lightblue; font-size:150%;",tab_html_nom),
                      # Nommage colonne
                      colnames = c("Thème", "Dossier de stockage", "Nom du fichier", "Extension", "Date", "Période", "Lien"),
                      # Configuration des options
                      options = list(
                                     # Ordre d'affichage des élèments de l'interface
                                     dom = "fBrtlip",
                                     # Mettre en surbrillance le texte recherché
                                     searchHighlight = TRUE,
                                     # Affichage du bouton du volet de recherche
                                     buttons = list("searchPanes"),
                                     columnDefs = list(
                                                      # Centre le contenu de la colonne qui contient les extensions
                                                      list(className = 'dt-center', targets = c("Extension", "mtime", "LIEN")),
                                                      # Masquer les colonnes non voulue dans le searchPanes
                                                      list(searchPanes = list(show = FALSE), targets = 1:2),
                                                      list(searchPanes = list(show = FALSE), targets = 4:4),
                                                      # Masque la colonne période
                                                      list(visible = FALSE, targets= "Période")
                                                      ),
                                     # Longueur du tableau (ne sert à rien avec le scroller)
                                     pageLength = 10,
                                     # Largeur automatique
                                     autoWidth = TRUE,
                                     # Changement de la langue
                                     language = list(# Langue de la page
                                                     paginate = list(previous = "Précédent", 'next' = "Suivant"),
                                                     sLengthMenu = "Afficher _MENU_ éléments",
                                                     info = "Enregistrement _START_ à _END_",
                                                     search = "Rechercher",
                                                     # Langue du panneau de recherche
                                                     searchPanes = list(collapse = "Filtrer",
                                                                        clearMessage = "Effacer les filtres",
                                                                        collapseMessage = "Réduire tout",
                                                                        showMessage = "Afficher tout")
                                                     ),
                                     # Couleur entête
                                     initComplete = JS(
                                                       "function(settings, json) {",
                                                                                  "$(this.api().table().header()).css({'background-color': 'green', 'color': 'white'});",
                                                                                  "}")
                                     )
                      )

# Export du tableau en html et indication du titre de la page
saveWidget(tab_html, paste("result/", paste(fichier_html_nom, ".html", sep =""), sep =""), title = tab_html_nom)