#!/bin/bash

function update {
  sudo apt-get update
  sudo apt-get --yes --force-yes upgrade
  sudo apt-get --yes --force-yes dist-upgrade
  sudo apt autoremove --purge
}

clear
echo -e "*-------------------------------------------*"
echo -e "|   M I S E  A  J O U R   D E   L ' O S     |"
echo -e "*-------------------------------------------*\n"

# update
update
clear

echo -e "\n*-------------------------------------------*"
echo -e "|   I N S T A L L   D E P E N D A N C Y     |"
echo -e "*-------------------------------------------*\n"

# Install dependancy
sudo apt-get --yes --force-yes install git-core
sudo apt-get --yes --force-yes install subversion
sudo apt-get --yes --force-yes install libjansson-dev
sudo apt-get --yes --force-yes install sqlite
sudo apt-get --yes --force-yes install autoconf
sudo apt-get --yes --force-yes install automake
sudo apt-get --yes --force-yes install libxml2-dev
sudo apt-get --yes --force-yes install libncurses5-dev
sudo apt-get --yes --force-yes install libtool
sudo apt-get --yes --force-yes install git
sudo apt-get --yes --force-yes install curl
sudo apt-get --yes --force-yes install wget
sudo apt-get --yes --force-yes install libnewt-dev
sudo apt-get --yes --force-yes install libssl-dev
sudo apt-get --yes --force-yes install libncurses5-dev
sudo apt-get --yes --force-yes install subversion
sudo apt-get --yes --force-yes install libsqlite3-dev
sudo apt-get --yes --force-yes install build-essential
sudo apt-get --yes --force-yes install libjansson-dev
sudo apt-get --yes --force-yes install libxml2-dev
sudo apt-get --yes --force-yes install uuid-dev

# Install zsh
sudo apt-get --yes --force-yes install zsh
sudo apt-get --yes --force-yes zsh-antigen
sudo apt-get --yes --force-yes zsh-common
sudo apt-get --yes --force-yes zsh-static
sudo apt-get --yes --force-yes zsh-syntax-highlighting
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

clear
echo -e "\n*-------------------------------------------*"
echo -e "| C O M P I L E   T H E    S O U R C E S    |"
echo -e "*-------------------------------------------*\n"

# Clone the sources
cd /opt
sudo curl -O http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-16-current.tar.gz
tar -xvf asterisk-16-current.tar.gz
sudo chown -Rv vagrant:vagrant /opt/
cd /opt/asterisk-16.6.1

# Compile asterisk
sudo contrib/scripts/get_mp3_source.sh
sudo ./contrib/scripts/install_prereq install
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
