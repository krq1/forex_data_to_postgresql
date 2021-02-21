#!/bin/sh

#PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/root/bin:/sbin:/usr/bin:/usr/sbin
#PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
#export DISPLAY=:0.0:

#removing duplicate lines
#cat *.csv | awk '!seen[$0]++' /root/pipeline/*.csv  > /root/pipeline/uat_stream/final.csv
#merging all csv

cat /root/pipeline/*.csv > /root/pipeline/uat_stream/final.csv

#cat *.csv | gawk -i inplace '!a[$0]++' *.csv > /root/pipeline/uat_stream/final.csv
#perl -ne 'print unless $seen{$_}++' *.csv > uat_stream/final.csv
#removing duplicates

awk '!a[$0]++' /root/pipeline/uat_stream/final.csv > /root/pipeline/uat_stream/final_.csv

#sorting by timestamp
sed 's/:/ /' /root/pipeline/uat_stream/final_.csv | sort -srk2 | sed 's/ /:/' > /root/pipeline/uat_stream/ff.csv

#move 3rd and 4th column to new file
cut -d, -f 3-4 /root/pipeline/uat_stream/ff.csv > /root/pipeline/uat_stream/ff2.csv
#remove uncesessary comma
cat /root/pipeline/uat_stream/ff2.csv | sed 's!/*,!!' > /root/pipeline/uat_stream/ff22.csv 
#move 5th and 6th column to new file
cut -d, -f 5-6 /root/pipeline/uat_stream/ff.csv > /root/pipeline/uat_stream/ff3.csv
#remove uncessary comma
cat /root/pipeline/uat_stream/ff3.csv | sed 's!/*,!!' > /root/pipeline/uat_stream/ff33.csv 

#same for 2nd column

cut -d, -f 2 /root/pipeline/uat_stream/ff.csv > /root/pipeline/uat_stream/ff1.csv

#cat uat_stream/ff1.csv | awk '{print strftime("%F %T." substr($0,length-2), substr($0, 1, length-3))}' uat_stream/ff1.csv > uat_stream/date.csv

perl -MPOSIX -lne '
  print strftime "%F %T", localtime $1 if /(.+)(.{3})/' /root/pipeline/uat_stream/ff1.csv > /root/pipeline/uat_stream/xoxo.csv

#sed -e n\;d uat_stream/date.csv > uat_stream/snap.csv

#cut -c-19 uat_stream/snap.csv > uat_stream/rework.csv

#sed -e n\;d uat_stream/rework.csv > uat_stream/xoxo.csv

sed 's/ /, /g'  /root/pipeline/uat_stream/ff33.csv > /root/pipeline/uat_stream/ff33_.csv
#merge files
paste -d,  /root/pipeline/uat_stream/xoxo.csv /root/pipeline/uat_stream/ff22.csv /root/pipeline/uat_stream/ff33_.csv > /root/pipeline/uat_stream/fff.csv


#sort by time
cat /root/pipeline/uat_stream/fff.csv | sort -M -k 2 > /root/pipeline/uat_stream/sort.csv


#add comma delimiter after each line
#sed 's/ /, /g' /root/pipeline/uat_stream/sort.csv > /root/pipeline/uat_stream/f1.csv

#remove duplicates
#awk '!a[$0]++' /root/pipeline/uat_stream/f1.csv > /root/pipeline/uat_stream/f11.csv


## whaat
#sed 's/\r$//' /root/pipeline/uat_stream/f11.csv > /root/pipeline/uat_stream/f2.csv

#awk '!a[$0]++' /root/pipeline/uat_stream/f2.csv > /root/pipeline/uat_stream/f_22.csv

#sed 's/\r$//' /root/pipeline/uat_stream/f_22.csv > /root/pipeline/uat_stream/f_33.csv

#awk '!seen[$0]++' /root/pipeline/uat_stream/f_33.csv > /root/pipeline/uat_stream/f_44.csv

#sort -k1 /root/pipeline/uat_stream/f_44.csv  > /root/pipeline/uat_stream/f_55.csv


#remove duplicates - needs work
#awk '!seen[$0]++' /root/pipeline/uat_stream/f_55.csv  > /root/pipeline/uat_stream/f_66.csv
#sed -r '/^.{,3}$/d' /root/pipeline/uat_stream/f_66.csv >  /root/pipeline/uat_stream/f_77.csv

more +2 /root/pipeline/uat_stream/sort.csv > /root/pipeline/uat_stream/f_88.csv

tail -n +7 /root/pipeline/uat_stream/f_88.csv > /root/pipeline/uat_stream/f_99.csv

psql -U postgres -d db2018 -c "SET datestyle = 'ISO,DMY'"
psql -U postgres -d db2018 -c "CREATE TABLE tmpp (time timestamp without time zone NOT NULL, ask real NOT NULL, bid real NOT NULL)"

#\copy tmp from 'uat_stream/f_77.csv' delimiter ',' CSV;
psql -U postgres -d db2018 -c "\copy realdeal (time, ask, bid) from '/root/pipeline/uat_stream/f_99.csv' delimiter ',' CSV"
psql -U postgres -d db2018 -c "insert into realdeal select * from tmpp on conflict do nothing"

#psql -U postgres -d forex -c "delete from realdeal
#    where exists (select 1
#                  from realdeal t2
#                  where t2.time = realdeal.time and
#                        t2.bid = realdeal.bid and
#                        t2.ask = realdeal.ask and
#                        t2.ctid > realdeal.ctid
#                 )"

psql -U postgres -d db2018 -c "DROP TABLE tmpp"

#removing all lines  for faster proccesing

current_date_time="`date +%Y%m%d%H%M%S`";
echo "done $current_date_time" >> /root/pipeline/log_uat_bulk


#truncate -s 0 *.csv uat_stream/*.csv
