############################################################
# Create the Backup-Script /var/lib/postgresql/backup.sh
# Modified by Rami Talat 06-JAN-2014
#
# ***  assure that the backup_dir is already exist first  ***
# 
############################################################
 
#!/bin/bash

# Location to place backups.
backup_dir="/var/backups/postgres_db"

sudo mkdir $backup_dir
sudo chown postgres $backup_dir
chmod +x /var/lib/postgresql/backup.sh
