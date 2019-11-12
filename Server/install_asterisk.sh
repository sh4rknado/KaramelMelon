#!/bin/bash

echo "*-------------------------------------------*"
echo "|   M I S E  A  J O U R   D E   L ' O S     |"
echo "*-------------------------------------------*"

# update
sudo apt-get update
sudo apt-get upgrade
sudo apt-get dist-upgrade

echo "*-------------------------------------------*"
echo "|   I N S T A L L   D E P E N D A N C Y     |"
echo "*-------------------------------------------*"

# Install dependancy
sudo apt-get install build-essential
sudo apt-get install git-core
sudo apt-get install subversion
sudo apt-get install libjansson-dev
sudo apt-get install sqlite autoconf
sudo apt-get install automake
sudo apt-get install libxml2-dev
sudo apt-get install libncurses5-dev
sudo apt-get install libtool


echo "*-------------------------------------------*"
echo "| C O M P I L E   T H E    S O U R C E S    |"
echo "*-------------------------------------------*"

# Clone the sources
cd /usr/src/
wget http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-15-current.tar.gz
tar -zxvf asterisk-15-current.tar.gz

# Compile asterisk
cd /usr/src/asterisk-15.5.0
./contrib/scripts/install_prereq install

echo "*----------------------------------------------------------------------*"
echo "|   I N S T A L L   C O M P L E T E D   S U C E S S F U L L Y          |"
echo "*----------------------------------------------------------------------*"
