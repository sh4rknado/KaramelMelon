#!/bin/bash

function update {
  sudo apt-get update
  sudo apt-get upgrade
  sudo apt-get dist-upgrade
  sudo apt autoremove --purge
}

echo "*-------------------------------------------*"
echo "|   M I S E  A  J O U R   D E   L ' O S     |"
echo "*-------------------------------------------*"

# update
update

echo "*-------------------------------------------*"
echo "|   I N S T A L L   D E P E N D A N C Y     |"
echo "*-------------------------------------------*"

# Install dependancy
sudo apt -y install build-essential
sudo apt -y install git-core
sudo apt -y install subversion
sudo apt -y install libjansson-dev
sudo apt -y install sqlite
sudo apt -y install autoconf
sudo apt -y install automake
sudo apt -y install libxml2-dev
sudo apt -y install libncurses5-dev
sudo apt -y install libtool
sudo apt -y install git
sudo apt -y install curl
sudo apt -y install wget
sudo apt -y install libnewt-dev
sudo apt -y install libssl-dev
sudo apt -y install libncurses5-dev
sudo apt -y install subversion
sudo apt -y install libsqlite3-dev
sudo apt -y install build-essential
sudo apt -y install libjansson-dev
sudo apt -y install libxml2-dev
sudo apt -y install uuid-dev

# Install zsh
sudo apt -y install zsh
sudo apt -y zsh-antigen
sudo apt -y zsh-common
sudo apt -y zsh-static
sudo apt -y zsh-syntax-highlighting


echo "*-------------------------------------------*"
echo "| C O M P I L E   T H E    S O U R C E S    |"
echo "*-------------------------------------------*"

# Clone the sources
cd /opt/asterisk-16.6.1
sudo chown -Rv vagrant:vagrant /opt/
sudo curl -O http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-16-current.tar.gz
tar -xvf asterisk-16-current.tar.gz

# Compile asterisk
cd asterisk-16.6.1/
sudo contrib/scripts/get_mp3_source.sh
sudo ./contrib/scripts/install_prereq install
update
./configure --with-jansson-bundled
make menuselect
make
sudo make install
sudo make samples
sudo make config
sudo make progdocs
sudo make install-logrotate
sudo ldconfig

if [ ! -d "/etc/asterisk/../logrotate.d" ]; then \
        sudo /usr/bin/install -c -d "/etc/asterisk/../logrotate.d" ; \
fi
sudo sed 's#__LOGDIR__#/var/log/asterisk#g' < contrib/scripts/asterisk.logrotate | sed 's#__SBINDIR__#/usr/sbin#g' > contrib/scripts/asterisk.logrotate.tmp
sudo /usr/bin/install -c -m 0644 contrib/scripts/asterisk.logrotate.tmp "/etc/asterisk/../logrotate.d/asterisk"
sudo rm -fv contrib/scripts/asterisk.logrotate.

# Resoulution Radius Error
sudo sed -i 's";\[radius\]"\[radius\]"g' /etc/asterisk/cdr.conf
sudo sed -i 's";radiuscfg => /usr/local/etc/radiusclient-ng/radiusclient.conf"radiuscfg => /etc/radcli/radiusclient.conf"g' /etc/asterisk/cdr.conf
sudo sed -i 's";radiuscfg => /usr/local/etc/radiusclient-ng/radiusclient.conf"radiuscfg => /etc/radcli/radiusclient.conf"g' /etc/asterisk/cel.conf

sudo systemctl stop asterisk.service
sudo systemctl start asterisk.service
sudo systemctl status asterisk.service

# Config FTP User
sudo apt-get install vsftpd
sudo cat /etc/vsftpd.conf | grep -v "^#"
sudo systemctl start vsftpd
sudo systemctl enable vsftpd
sudo systemctl status vsftpd
sudo useradd ftpuser -s /sbin/nologin


echo "*----------------------------------------------------------------------*"
echo "|   I N S T A L L   C O M P L E T E D   S U C E S S F U L L Y          |"
echo "*----------------------------------------------------------------------*"


# Config Database
sudo -u postgres psql
create database asteriskdb;
create user asteriskuser with encrypted password 'asteriskpass';
grant all privileges on database asteriskdb to asteriskuser;
