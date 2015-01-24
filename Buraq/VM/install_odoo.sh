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
wget https://raw.githubusercontent.com/ramitalat/Ascend_Solutions/master/Buraq/VM/odoo_install_asch.sh

chmod +x odoo_install_asch.sh 
sudo ./odoo_install_asch.sh 2>&1 | tee odoo_installation.log

# Get the backup script

# Location to place backups.
backup_dir="/var/backups/postgres_db"

# run the extention sript to odoo_install.sh
wget https://raw.githubusercontent.com/ramitalat/Ascend_Solutions/master/Buraq/VM/script_ext.sh
sudo sh script_ext.sh
sudo mkdir $backup_dir
sudo chown postgres $backup_dir

# create the backup script ...
sudo su - postgres -c "wget https://raw.githubusercontent.com/ramitalat/Ascend_Solutions/master/Buraq/VM/backup.sh"
sudo chmod +x backup.sh

# modifying postgres crontab
sudo su - postgres -c "crontab -l | { cat; echo \"45 */4 * * * /var/lib/postgresql/backup.sh > /dev/null 2>&1\"; } | crontab -"

# return back to your current dir
cd -
