#!/bin/sh
##############################
#Script by Anas V
##############################

#Substitute your postgresql root username in the below given line
PGUSER=postgres
#Substitute your postgresql root password in the below given line
#PGPASSWORD=mypostgre
PGPASSWORD=pearls
export PGUSER PGPASSWORD

tdate=`date +%d-%b-%Y`

if [ $# -lt 1 ]

# Check if there is atleast one argument [i.e the database whose dump is to be taken]
#First argument is mandatory - Databse name
#Second argument is optional - Destination path to save dump
then

        echo "Bad Arguments"
        echo "-----------------------------------"
        echo "USAGE : pg_dmp.sh <databasename> [outputfile]"
        echo "-----------------------------------"
        exit 1
else

#if one or more arguments were provided
        if [ $# -ge 2 ]
        #if arguments provided is greater than or equal to 2
        then
		#Comment out the below given file exist check and it's associated messages
		# if you want to run the pg_dmpsh script to run silently. i.e from a cron or at job
		# without any user interaction. Then the output dump file will be rewritten if a file
		# already exists. 
                if [ -f $2  ]
                # if destination file ie argument 2 is already existing
                then
                        #Show confirmation message to confirm whether replace file with new one or exit
                        dialog --title "Confirm File Replace" --backtitle "pg_dmp.sh"\
                        --yesno "\nFile already exist, Do you want to replace it with '$2' file" 7 90
                        sel=$?
                        case $sel in
                        #if Yes then take dump and replace the existing file with new dump
                        0)  pg_dump $1 -f $2 -i -x -O -R;;
                        #if No then exit
                        1) exit 1 ;;
                        #if escape then exit
                        255) exit 1;;
                        esac
                else
                        #if destination file does not exist then create and save the dump in destination path
                         pg_dump $1 -f $2 -i -x -O -R
                fi
        else
                if [ $# -eq 1 ]
                #if arguments provided is equal to 1
                then
                        if [ -d $HOME/pg_backup_$1 ]
                        #if folder name pg_backup_'databsename' exist in the current users home directory
                        then
                                if [ -f $HOME/pg_backup_$1/$1_$tdate ]
                                #if destination file name exist in pg_backup_'databasename' folder in current users home dierectory
                                then
                                #Show confirmation message for replacing the file with new dump
                                        dialog --title "Confirm File Replace" --backtitle "pg_dump.sh"\
                                        --yesno "\nFile already exist, Do you want to replace it with '$HOME/pg_backup_$1/$1_$tdate' file" 7 90
                                        sel=$?
                                        case $sel in
                                        #if Yes then replace the file with new dump file
                                        0) pg_dump $1 -f $HOME/pg_backup_$1/$1_$tdate -i -x -O -R;;
                                        #if No then exit
                                        1) exit 1 ;;
                                        #if escape thenexit
                                        255) exit 1;;
                                        esac
                                else
                                        #if destination file does not exist then create and save the dump
                                        pg_dump $1 -f $HOME/pg_backup_$1/$1_$tdate -i -x -O -R
                                fi
                        else
                                #if folder pg_backup_'databsename' does not exist in the current users home dierectory then
                                #Create a new folder
                                mkdir $HOME/pg_backup_$1
                                #then create dump and save it
                                pg_dump $1 -f $HOME/pg_backup_$1/$1_$tdate -i -x -O -R
                                #if databse to take does not exist then Delete the folder created
                                if [ $? -ne 0 ]
                                then
                                        rmdir $HOME/pg_backup_$1
                                fi
                        fi
                fi
        fi
        if [ $# -gt 2 ]
        #if arguments passed where greater than 2 then  show message
        then
                echo "Extra Arguments ignored"
        fi
fi

#reset PGUSER and PGPASSWORD
PGUSER=""
PGPASSWORD=""
export PGUSER PGPASSWORD
#End
