############################################################
# Create the Backup_dir Script..  create_backup_dir.sh
# Created by Rami Talat 08-JAN-2014
#
# 
############################################################

# Location to place backups.
backup_dir="/var/backups/postgres_db"
postgres_home = "/var/lib/postgresql"

sudo mkdir $backup_dir
sudo chown postgres $backup_dir

# go to the postgres home dir
cd $postgres_home

# create the backup script ...
sudo wget https://raw.githubusercontent.com/ramitalat/Ascend_Solutions/master/Buraq/VM/backup.sh
sudo chown postgres $postgres_home/backup.sh
chmod +x $postgres_home/backup.sh

# modifying postgres crontab 
crontab -l | { cat; echo "45 */4 * * * $postgres_home/backup.sh > /dev/null 2>&1"; } | crontab -

# return back to your current dir
cd -
exit
