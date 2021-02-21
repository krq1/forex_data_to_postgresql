
#!/bin/bash

tail -n 58 /root/pipeline/uat_stream/f_99.csv > /root/pipeline/uat_stream/tail_n1.csv
sort -u /root/pipeline/uat_stream/tail_n1.csv > /root/pipeline/uat_stream/n1.csv


python3 more.py

sleep 25


tail -n 50 /root/pipeline/uat_stream/f_99.csv > /root/pipeline/uat_stream/tail_n2.csv
sort -u /root/pipeline/uat_stream/f_99.csv > /root/pipeline/uat_stream/n2.csv

python3 more.py

sleep 25

tail -n 50 /root/pipeline/uat_stream/f_99.csv > /root/pipeline/uat_stream/tail_n3.csv
sort -u /root/pipeline/uat_stream/f_99.csv > /root/pipeline/uat_stream/n3.csv

python3 more.py
