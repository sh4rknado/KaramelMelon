## Procédure de configuration - Conférence
### Configuration du fichier confbridge.conf
    nano /etc/asterisk/confbridge.conf

        [default_user]
        type=user
        pin=1234
        music_on_hold_when_empty=yes
        announce_user_count=yes

        [default_bridge]
        type=bridge
        max_members=10

* type : précise le type d'utilisateur
* pin : ajoute un mot de passe pour les utilisateurs du groupe [default_user]
* music_on_hold_when_empty : ajoute une musique lorsque la conférence est vide
* announce_user_count : une voix indique combien d'utilisateur sont sur la conférence

### Configuration du fichier extensions.conf
    nano /etc/asterisk/extensions.conf

        exten => 300,1,Progress()
        exten => 300,2,Wait(1)
        exten => 300,3,ConfBridge(1,default_bridge,default_user)

Configure le numéro 300 pour l'utilisation d'une salle de conférence. A l'heure actuelle, seul le groupe "default_user" peuvent accéder à la conférence.

### Configuration du fichier users.conf
    nano /etc/asterisk/users.conf

        [local](!)
        Type=friend
        Host = dynamic
        Dtmfmode=rfc2833
        Disallow = all
        Allow = ulaw
        Context = local

Création d'un groupe "local" indiquant les configurations de toutes les salles de conférences.

        [300](local)
        Callerid = "Conference" <300>
        Secret =
    
Création d'un user "local" (salle de conférence) avec le numéro 300. Aucun mot de passe n'est configuré.

### Fin de la configuration

Sur le téléphone IP, entrez le numéro 300 et rentrer le mot de passe 1 2 3 4. 