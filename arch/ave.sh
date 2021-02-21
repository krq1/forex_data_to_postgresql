

#!/bin/bash

tail -n 50 uat_stream/f_99.csv > uat_stream/f_99_tail.csv
i=1
while read myline
do
    if [ $i -eq 1 ]
    then
        echo "Report Date: $(cut -d" " -f2 uat_stream/f_99_tail.csv)" > output.txt
    elif [ $i -gt 3 ]
    then
        echo $myline > temp.txt
        proc=$(cut -d" " -f3 temp.txt)
        echo $proc > temp.txt
        cat temp.txt >> temp2.txt
    fi
    i=$(expr $i + 1)
done <ornek2-c.txt

index=$(expr $i - 4)
 
cat temp2.txt | awk '{ sum+=$1 } END {print sum}'
average=$(echo "scale=4; $sum/$index"|bc)
echo $average
exit 0
