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
make menuselect
make
sudo make install
sudo make samples
sudo make config
sudo make install-logrotate


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


echo "*----------------------------------------------------------------------*"
echo "|   I N S T A L L   C O M P L E T E D   S U C E S S F U L L Y          |"
echo "*----------------------------------------------------------------------*"
