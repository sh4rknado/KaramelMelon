# Mettre en français les téléphones Polycom

On peut uniquement avoir les Polycoms en FR depuis la dernière version du bootroom. Il faut donc télécharger la version 3.5.5 du bootroom (2345-12200-001.sip.ld).

[Lien du fichier - Download](http://support.ubixtechnologies.net/firmware/Polycom/)

Dans le fichier 0000000000.cfg, spécifier dans la balise "APP_FILE_PATH" le chemin du fichier SIP "2345-12200-001.sip.ld" (on le trouve sur le stite de Polycom).

Dans le fichier de langue (version français), il faut supprimer tous les espaces vides pour que le fichier fasse moins de 52Ko.

Redémarrer le téléphone pour qu'il aille rechercher le bon bootroom. Ensuite, sur le téléphone "Menu>Configuration>de base>Préférence>Langage>Français (fr-fr).

Il peut être nécessaire de redémarrer complétement le téléphone pour qu'il trouve le fichier de langue.
