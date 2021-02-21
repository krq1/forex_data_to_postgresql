#!/bin/bash

#cd /root/pipeline/

#cat e*.csv >> /root/pipeline/weekly_backup_csv/e_data.csv


PGPASSWORD=mlekomleko6 psql -U postgres -d db2018 -c "delete from realdeal
   where exists (select 1
                from realdeal t2
               where t2.time = realdeal.time and
			t2.bid = realdeal.bid and
		t2.ask = realdeal.ask and
                        t2.ctid > realdeal.ctid
                )"

truncate -s 0 *.csv

cd /root/pipeline/weekly_backup_csv/

#sort -u e_data.csv >> clean_stuff.csv

#psql -U postgres -d db2018 -c "SET datestyle = 'ISO,DMY'"
#psql -U postgres -d db2018 -c "CREATE TABLE tmp2 (time timestamp without time zone NOT NULL, ask real NOT NULL, bid real NOT NULL)"

#psql -U postgres -d db2018 -c "\copy realdeal (time,ask,bid) from '/root/pipeline/weekly_backup_csv/clean_stuff.csv' delimiter ',' CSV"

#psql -U postgres -d db2018 -c "insert into realdeal select * from tmp2 on conflict do nothing"

current_date_time="`date +%Y%m%d%H%M%S`";
echo "done $current_date_time" >> /root/pipeline/log_db_del_dup

#truncate -s 0 /root/pipeline/log*
