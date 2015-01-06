############################################################
# Backup-Script /var/lib/postgresql/backup.sh
#
# Modified by Rami Talat 06-JAN-2014
#
# Should bu run by postgres user
# Reference: https://www.odoo.com/forum/help-1/question/how-to-setup-a-regular-postgresql-database-backup-4728
############################################################
 
#!/bin/bash
# Create the backup dir if not existed
OB_DIR="/var/backups/postgres_db"
mkdir -p $OB_DIR

# Location of the backup logfile.
logfile="$OB_DIR/logfile.log"

# Location to place backups.
backup_dir="$OB_DIR"

#String to append to the name of the backup files
backup_date=`date +%Y-%m-%d_%H-%M`

#Numbers of days you want to keep copie of your databases
number_of_days=10
touch $logfile
databases=`psql -l -t | cut -d'|' -f1 | sed -e 's/ //g' -e '/^$/d'`
for i in $databases; do
  if [ "$i" != "template0" ] && [ "$i" != "template1" ] && [ "$i" != "postgres" ]; then
    # backupfile=$backup_dir$i.$backup_date.sql.gz
    # echo Dumping $i to $backupfile
    # pg_dump $i|gzip > $backupfile
	
    timeinfo=`date '+%T %x'`
    echo "Backup and Vacuum started at $timeinfo for time slot $timeslot on database: $i " >> $logfile
    /usr/bin/vacuumdb -z -U postgres $i >/dev/null 2>&1
    # /usr/bin/pg_dump $i -U postgres | gzip > "$backup_dir/openerp-$i-$timeslot-database.gz"
    timeinfo=`date '+%T %x'`
    pg_dump -U postgres --format=c --file=$backup_dir/$i-$timeslot.dump $i
    gzip $backup_dir/$i-$timeslot.dump
    echo "Backup and Vacuum complete at $timeinfo for time slot $timeslot on database: $i " >> $logfile
  fi
done
find $backup_dir -type f -prune -mtime +$number_of_days -exec rm -f {} \;

############################################################
# the next step...
# open your terminal
 
# su
# su postgres
# crontab -e
# 45 */4 * * * /var/lib/postgresql/backup.sh > /dev/null 2>&1
############################################################
