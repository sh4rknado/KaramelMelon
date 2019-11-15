# KaramelMelon :melon:

KaramelMelon 2019

## Table des matières

- [KaramelMelon :melon:](#karamelmelon-melon)
  - [Table des matières](#table-des-mati%c3%a8res)
    - [Download & Install Vagrant](#download--install-vagrant)
    - [Get Asterisk Console](#get-asterisk-console)
    - [Path Config files](#path-config-files)
  - [Links](#links)
    - [Documentation Polycom](#documentation-polycom)
    - [Documentation Avaya](#documentation-avaya)
      - [Autres](#autres)
      - [Téléchargements Avaya (firmware, ...)](#t%c3%a9l%c3%a9chargements-avaya-firmware)
    - [Documentation Fonctionnalités](#documentation-fonctionnalit%c3%a9s)

### Download & Install Vagrant

    vagrant up

> Notes: You can make one or 2 coffee and waiting

### Get Asterisk Console

    asterisk -cvvvvvvvvvvr

### Path Config files

    /etc/asterisk/sip.conf

    /etc/asterisk/users.conf

    /etc/asterisk/cdr_pgsql.conf

    /etc/asterisk/extensions.conf

> Notes : After Add user do you use
reload

## Links

### Documentation Polycom

https://support.polycom.com/content/dam/polycom-support/products/voice/soundpointip/release-notes/en/boot-rom-release-notes-4-1-3.pdf

http://ftp.tecnoera.com/polycom/4.0.1/

https://community.polycom.com/t5/VoIP-SIP-Phones/FAQ-How-can-I-check-the-SIP-and-UCS-UC-Software-and-BootROM/td-p/4211

http://support.ubixtechnologies.net/firmware/Polycom/

### Documentation Avaya

[**Documents
officiels**](https://support.avaya.com/documents/documents-by-contenttype.action?product_id=P0599&product_name=1100%20Series%20IP%20Deskphones&release_number=releaseId&contentType=)
>Cocher Admin & System Programming et User Guides

| Guide       | Nom du fichier                                                                    |
| ----------- | --------------------------------------------------------------------------------- |
| Admin       | SIP Software 4.4 for Avaya 1100 Series IP Deskphones-Administration (31 Aug 2017) |
| Utilisateur | 1140E IP Deskphone with SIP Software User Guide (20 Dec 2017)                     |

>sont les deux fichiers pdf utiles, ils sont dans le dossier `Documentation/Avaya/`

#### Autres

https://www.tek-tips.com/viewthread.cfm?qid=1696295

#### Téléchargements Avaya (firmware, ...)

[Mise à jour
utilisée](https://support.avaya.com/downloads/download-details.action?contentId=C20186281340103310_8&productId=P0599&releaseId=SIP%204.x)

| File                    | Size    | Instructions                                                               |
| ----------------------- | ------- | -------------------------------------------------------------------------- |
| SIP1140e04.04.33.00.bin | 4.84 MB | Binary file for 1140E IP Deskphone.                                        |
| langs_files.zip         | 621 KB  | Language files for SIP Software Release 4.4.10 for 11xx/12xx IP Deskphones |

### Documentation Fonctionnalités

[Groupe d'appel, Redirection](https://wiki.mdl29.net/lib/exe/fetch.php?media=braveo:01_tp_asterisk_base.pdf)

[SMS](https://wiki.asterisk.org/wiki/display/AST/SMS)

[Vidéo pour les conférences](https://www.youtube.com/watch?v=n__WkoHhTeM)

[Services Voice Mail](https://tsrit.com/2014/07/19/configuration-de-base-de-voicemail-sur-asterisk-2/)

[Service Voicemail 2](http://denisrosenkranz.com/tutomise-en-place-des-boites-vocales-dans-asterisk-et-configuration-de-lenvoi-de-mail/)

[Contact commun](https://support.polycom.com/content/dam/polycom-support/products/voice/soundstation-ip-series/user/en/spip-ssip-vvx-admin-guide-sip-3-2-2-eng.pdf)
[Ring Group] https://www.networklab.fr/ring-group/
