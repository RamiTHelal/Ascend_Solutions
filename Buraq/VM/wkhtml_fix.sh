#!/bin/bash
################################################################################
# wkhtml_fix.sh
# Author: Rami Talat
#-------------------------------------------------------------------------------
#
# This script Script for Fixing wkhtmltopdf pkg
#
################################################################################

# Remove if exist wkhtmltox-0.12.2.1_linux-trusty-i386.deb 
sudo rm -f wkhtmltox-0.12.2.1_linux-trusty-i386.deb

sudo apt-get install -y wkhtmltopdf
sudo apt-get install -f

sudo wget http://downloads.sourceforge.net/project/wkhtmltopdf/0.12.2.1/wkhtmltox-0.12.2.1_linux-trusty-i386.deb
sudo dpkg -i wkhtmltox-0.12.2.1_linux-trusty-i386.deb             
sudo ln -s /usr/local/bin/wkhtmltopdf /usr/bin/wkhtmltopdf
sudo ln -s  /usr/local/bin/wkhtmltoimage /usr/bin/wkhtmltoimage

sudo cp /usr/local/bin/wkhtmltopdf /usr/bin
sudo cp /usr/local/bin/wkhtmltoimage /usr/bin
