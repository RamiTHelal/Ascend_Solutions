#!/bin/bash
################################################################################
# wkhtml_fix.sh
# Author: Rami Talat
#-------------------------------------------------------------------------------
# This script Script for Fixing wkhtmltopdf pkg
################################################################################

echo -e "\n---- Install WkHtmlToPdf 0.12.1 ----"
sudo apt-get install -fy wkhtmltopdf
sudo apt-get install -f

# sudo wget http://sourceforge.net/projects/wkhtmltopdf/files/archive/0.12.1/wkhtmltox-0.12.1_linux-trusty-i386.deb/download
sudo wget -O wkhtmltox-0.12.1_linux-trusty-i386.deb  http://sourceforge.net/projects/wkhtmltopdf/files/archive/0.12.1/wkhtmltox-0.12.1_linux-trusty-i386.deb/download


sudo dpkg -i wkhtmltox-0.12.1_linux-trusty-i386.deb         
sudo cp /usr/local/bin/wkhtmltopdf /usr/bin
sudo cp /usr/local/bin/wkhtmltoimage /usr/bin

echo -e "Wkhtmltopdf is installed!"
