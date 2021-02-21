#!/usr/bin/python3

import csv

with open('/root/pipeline/uat_stream/n1.csv', 'r') as f:
  reader = csv.reader(f)
  n1= list(reader)

print(n1)
# [['This is the first line', 'Line1'],
#  ['This is the second line', 'Line2'],
#  ['This is the third line', 'Line3']]
