#!/bin/bash
################################################################################
# Install extra modules to customs dir
# Author: Rami Talat
#
################################################################################
##fixed parameters
#openerp
OE_USER="odoo"

# Getting zip repos...
sudo su $OE_USER -c "wget https://github.com/mohamedhagag/dvit-odoo8/archive/master.zip"
sudo su $OE_USER -c "mv master.zip rami_1.zip"

sudo su $OE_USER -c "wget https://github.com/codup/odoo-eam/archive/master.zip"
sudo su $OE_USER -c "mv master.zip rami_2.zip"

sudo su $OE_USER -c "wget https://github.com/OCA/account-financial-reporting/archive/8.0.zip"
sudo su odoo -c "mv 8.0.zip rami_3.zip"

# Unzip all
sudo su $OE_USER -c "find . -name 'rami_*.zip' -print0 | xargs -0 -I {} -P 10 unzip {}"

# Cleanup the zips
sudo su $OE_USER -c "find . -name 'rami_*.zip' -print0 | xargs -0 -I {} -P 10 rm {}"

# Move teh subdirs to the custom dir
sudo su $OE_USER -c "mv account-financial-reporting-8.0/ ramid_account-financial-reporting-8.0/"
sudo su $OE_USER -c "mv odoo-eam-master/ ramid_odoo-eam-master/"
sudo su $OE_USER -c "mv dvit-odoo8-master/ ramid_dvit-odoo8-master/"

sudo su $OE_USER -c "mv ramid_*/* ."
sudo su $OE_USER -c "rm -rd ramid_*"

