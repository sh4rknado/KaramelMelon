# Sonnerie Avaya

* Télécharger un fichier audio ou vidéo
* [online-convert.com](https://www.online-convert.com)

1. Convert to wav
2. bit resolution : 8 bit
3. sampling rate : 8000 Hz
4. Trim audio : Choisir la durée du fichier audio (par ex 10 secondes)
5. Normalize Audio : yes
6. Advanced Options
   1. PCM format : PCM A-law
7. Télécharger le fichier
8. Le mettre sur un ftp (ou autre) accessible par l'avaya
9. Rajouter une section [TONES] dans le fichier de provisionning de l'avaya (voir `Avaya/114eSIP.cfg`)
