############################################################
# run_scripts.sh
# Created by Rami Talat 08-JAN-2014
#
# 
############################################################

# Location to place backups.
backup_dir="/var/backups/postgres_db"

sudo mkdir $backup_dir
sudo chown postgres $backup_dir

# create the backup script ...
sudo su - postgres -c "wget https://raw.githubusercontent.com/ramitalat/Ascend_Solutions/master/Buraq/VM/backup.sh"
sudo chmod +x backup.sh

# modifying postgres crontab 
sudo su - postgres -c "crontab -l | { cat; echo \"45 */12 * * * /var/lib/postgresql/backup.sh > /dev/null 2>&1\"; } | crontab -"
# return back to your current dir
cd -

