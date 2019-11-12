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
sudo apt-get install build-essential git-core subversion libjansson-dev sqlite autoconf automake libxml2-dev libncurses5-dev libtool


echo "*-------------------------------------------*"
echo "| C O M P I L E   T H E    S O U R C E S    |"
echo "*-------------------------------------------*"

# Clone the sources
cd /opt
sudo chown -Rv vagrant:vagrant /opt/
wget http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-17-current.tar.gz
tar -xvf asterisk-17-current.tar.gz

# Compile asterisk
cd asterisk-17.0.0/
sudo ./contrib/scripts/install_prereq install
update
./configure --with-jansson-bundled
make
sudo make install
make samples
make config
make install-logrotate

echo "*----------------------------------------------------------------------*"
echo "|   I N S T A L L   C O M P L E T E D   S U C E S S F U L L Y          |"
echo "*----------------------------------------------------------------------*"
