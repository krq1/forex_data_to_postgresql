
#!/bin/bash

cp /root/pipeline/weekly_backup_csv/clean_stuff.csv /root/pipeline

#bash /root/pipeline/uat.sh

#bash /root/pipeline/db_*

sleep 120

#truncate -s 0 clean_stuff.csv

#truncate -s 0 *.csv
