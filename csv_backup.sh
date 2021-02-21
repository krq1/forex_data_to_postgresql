#!/bin/bash
#weekly csv backup
_now=$(date +"%m_%d_%Y")
_file="/root/pipeline/backup_csv$_now.zip"
echo "Starting backup to $_file..."
cd /root/pipeline/weekly_backup_csv
zip $_file clean_stuff.csv
mv /root/pipeline/backup_csv* /root/pipeline/weekly_backup_csv
