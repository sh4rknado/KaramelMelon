#!/bin/bash

LIST_PACKAGES="vsftpd odbcinst odbc-postgresql odbc-mdbtools mysql-server git-core subversion libjansson-dev sqlite autoconf automake libxml2-dev libncurses5-dev libtool git curl wget libnewt-dev libssl-dev libncurses5-dev subversion libsqlite3-dev build-essential libxml2-dev libjansson-dev uuid-dev zsh zsh-antigen zsh-common zsh-static zsh-syntax-highlighting"
DB_PASS="vagrant"
DB_USER="vagrant"
FTP_USER="ftpuser"
FTP_PASS="ftpuser"

#################################################### <  I N S T A L L   D E P E N D A N C Y   > #############################################################

function update {
  clear
  echo -e "*-------------------------------------------*"
  echo -e "|   M I S E  A  J O U R   D E   L ' O S     |"
  echo -e "*-------------------------------------------*\n"

  sudo apt-get update
  sudo apt-get --yes --force-yes upgrade
  sudo apt-get --yes --force-yes dist-upgrade
  sudo apt autoremove --purge
}

function install_dependancy {

  for pack in $LIST_PACKAGES
  do
    clear
    echo -e "\n*-------------------------------------------*"
    echo -e "|   I N S T A L L   D E P E N D A N C Y     |"
    echo -e "*-------------------------------------------*\n"

    sudo apt-get --yes --force-yes install $pack
  done

  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
}

function install_ftp {

echo "
# [ General Section ]
listen=YES
anonymous_enable=NO
local_enable=YES
write_enable=YES
listen_port=21
dirmessage_enable=YES
use_localtime=YES
xferlog_enable=YES
connect_from_port_20=YES
secure_chroot_dir=/var/run/vsftpd/empty
pam_service_name=vsftpd
rsa_cert_file=/etc/ssl/certs/ssl-cert-snakeoil.pem
rsa_private_key_file=/etc/ssl/private/ssl-cert-snakeoil.key
ssl_enable=NO
# [ Chroot Section ]
chroot_local_user=YES
chroot_list_enable=YES
chroot_list_file=/etc/vsftpd.chroot_list " > /etc/vsftpd.conf

  echo "$FTP_USER" >> /etc/vsftpd.chroot_list

  # Config FTP User
  sudo useradd $FTP_USER
  yes "$FTP_PASS" | sudo passwd $FTP_USER
  # sudo cat /etc/vsftpd.conf | grep -v "^#"

  sudo systemctl start vsftpd
  sudo systemctl enable vsftpd
}

function config_database {
  clear
  echo
  echo -e "\n*-------------------------------------------*"
  echo -e "|     I N I T   T H E   DA T A B A S  E     |"
  echo -e "*-------------------------------------------*\n"

  echo -e "\nSecure the database\n"

sudo /usr/bin/mysql_secure_installation << EOF
y
$DB_PASS
$DB_PASS
y
y
y
y

EOF

	echo -e "\nActivation du Service MySQL\n"
  sudo systemctl restart mysqld
  sudo systemctl enable mysqld

  echo -e "\n Create the database\n"
  mysql -u root -p$DB_PASS -e "CREATE USER 'asterisk'@'%' IDENTIFIED BY '"$DB_PASS"';"
  mysql -u root -p$DB_PASS -e "CREATE DATABASE asterisk;"
  mysql -u root -p$DB_PASS -e "GRANT ALL PRIVILEGES ON asterisk.* TO 'asterisk'@'%';"
}

############################################################################################################################################################
############################################################################################################################################################


#################################################### <  I N S T A L L   A S T E R I S K  > #############################################################

function install_asterisk {
  clear
  echo -e "\n*-------------------------------------------*"
  echo -e "| C O M P I L E   T H E    S O U R C E S    |"
  echo -e "*-------------------------------------------*\n"


  # Clone the sources
  sudo chown -Rv vagrant:vagrant /opt/
  cd /opt
  curl -O http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-16-current.tar.gz
  tar -xvf asterisk-16-current.tar.gz
  cd /opt/asterisk-16.6.1

  # Compile asterisk
  sudo contrib/scripts/get_mp3_source.sh
  yes "y" | sudo ./contrib/scripts/install_prereq install
  update
  ./configure --with-jansson-bundled
  make menuselect

  echo -e "\nMake processing ...\n"
  make -j4
  echo -e "\nMake Install processing ...\n"
  sudo make -j4 install
  echo -e "\nMake Samples processing ...\n"
  sudo make -j4 samples
  echo -e "\nMake Config processing ...\n"
  sudo make -j4 config
  echo -e "\nMake doc processing ...\n"
  sudo make -j4 progdocs
  echo -e "\nMake logrotate processing ...\n"
  sudo make -j4 install-logrotate
  sudo ldconfig

  if [ ! -d "/etc/asterisk/../logrotate.d" ]; then \
          sudo /usr/bin/install -c -d "/etc/asterisk/../logrotate.d" ; \
  fi
  sudo sed 's#__LOGDIR__#/var/log/asterisk#g' < contrib/scripts/asterisk.logrotate | sed 's#__SBINDIR__#/usr/sbin#g' > contrib/scripts/asterisk.logrotate.tmp
  sudo /usr/bin/install -c -m 0644 contrib/scripts/asterisk.logrotate.tmp "/etc/asterisk/../logrotate.d/asterisk"
  sudo rm -fv contrib/scripts/asterisk.logrotate.
}

function fix_bug {
    # Resoulution Radius Error
    sudo sed -i 's";\[radius\]"\[radius\]"g' /etc/asterisk/cdr.conf
    sudo sed -i 's";radiuscfg => /usr/local/etc/radiusclient-ng/radiusclient.conf"radiuscfg => /etc/radcli/radiusclient.conf"g' /etc/asterisk/cdr.conf
    sudo sed -i 's";radiuscfg => /usr/local/etc/radiusclient-ng/radiusclient.conf"radiuscfg => /etc/radcli/radiusclient.conf"g' /etc/asterisk/cel.conf

    sudo systemctl enable asterisk.service
    sudo systemctl start asterisk.service
    sudo systemctl status asterisk.service
}

echo "*----------------------------------------------------------------------*"
echo "|   I N S T A L L   C O M P L E T E D   S U C E S S F U L L Y          |"
echo "*----------------------------------------------------------------------*"

# update
update
install_dependancy
install_ftp
config_database
install_asterisk
fix_bug
