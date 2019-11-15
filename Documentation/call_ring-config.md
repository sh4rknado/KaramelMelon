## Configuration du mode Ring group

Très utilisé en entreprise, permet de regrouper plusieurs utilisateurs dans un groupe et d'y ajouter un comportement en cas d'appel. 

Deux modes de configurations d'un ring groupe : 
* **Round Robin** : faire sonner les postes les uns après les autres
* **Ring All** : faire sonner tous les postes en même temps (c'est ce que l'on va utiliser pour notre projet)

#### Configuration
    nano /etc/asterisk/extensions.conf

        exten => 900,1,Dial(SIP/6001&SIP/6002&SIP/6003,10)
        exten => 900,2,VoiceMail(6005@student)

En contactant le numéro 900, les postes téléphoniques 6001 & 6002 vont être appelés. Le premier poste qui répond va "prendre l'appel", plus aucun poste ne poura prendre et rejoindre l'appel. 

Si personne ne répond, l'utilisateur pourra laisser un message sur la messagerie du poste téléphonique 6001.
