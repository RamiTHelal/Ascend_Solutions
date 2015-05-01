#!/bin/bash
################################################################################
# Script for Installation: ODOO on Ubuntu 14.04 LTS
# Author: Rami Talat
#-------------------------------------------------------------------------------
#
# This script will install ODOO Server on
# clean Ubuntu 14.04 Server
#
# EXAMPLE:
# ./odoo-install
#
################################################################################

# Get the odoo_install script
#--------------------------------------------------
# Installing Odoo script
#--------------------------------------------------
echo -e "\n---- Installing Odoo script ----"

wget https://raw.githubusercontent.com/ramitalat/Ascend_Solutions/master/Buraq/VM/odoo_install_asch.sh

chmod +x odoo_install_asch.sh 
sudo ./odoo_install_asch.sh 2>&1 | tee odoo_installation.log

#--------------------------------------------------
# Installing the extra_apps script
#--------------------------------------------------
echo -e "\n---- Installing the extra_apps script ----"
cd $OE_HOME/custom/addons
wget https://raw.githubusercontent.com/ramitalat/Ascend_Solutions/master/Buraq/VM/extra_apps.sh
sudo sh extra_apps.sh

#--------------------------------------------------
# Installing the backup script
#--------------------------------------------------
echo -e "\n---- Installing the backup script ----"

# Location to place backups.
backup_dir="/var/backups/postgres_db"

sudo mkdir $backup_dir
sudo chown postgres $backup_dir

# create the backup script ...
sudo su - postgres -c "wget https://raw.githubusercontent.com/ramitalat/Ascend_Solutions/master/Buraq/VM/backup.sh"
sudo chmod +x /var/lib/postgresql/backup.sh

# modifying postgres crontab
sudo su - postgres -c "crontab -l | { cat; echo \"45 */12 * * * /var/lib/postgresql/backup.sh > /dev/null 2>&1\"; } | crontab -"

# return back to your current dir
cd -
