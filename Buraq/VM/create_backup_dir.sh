############################################################
# Create the Backup-Script /var/lib/postgresql/backup.sh
# Modified by Rami Talat 06-JAN-2014
#
# ***  assure that the backup_dir is already exist first  ***
# 
# Reference: https://www.odoo.com/forum/help-1/question/how-to-setup-a-regular-postgresql-database-backup-4728
############################################################
 
#!/bin/bash

# Location to place backups.
backup_dir="/var/backups/postgres_db"

sudo mkdir $backup_dir
sudo chown postgres $backup_dir
chmod +x /var/lib/postgresql/backup.sh
