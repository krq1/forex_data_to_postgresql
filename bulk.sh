#!/bin/bash


psql -U postgres -d db2018 -c "SET datestyle = 'ISO,DMY'"
psql -U postgres -d db2018 -c "CREATE TABLE tmpp (time timestamp without time zone NOT 
NULL, ask real NOT NULL, bid real NOT NULL)"     
psql -U postgres -d db2018 -c "\copy realdeal (time, ask, bid) from
 '/root/pipeline/uat_stream/f_99.csv"
psql -U postgres -d db2018 -c "insert into realdeal select * from tmpp on conflict do nothing" 
