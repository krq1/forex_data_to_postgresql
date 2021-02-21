#!/bin/bash

sleep 5; /bin/bash /root/pipeline/uat.sh
sleep 10; /bin/bash /root/pipeline/uat.sh 
sleep 15; /bin/bash /root/pipeline/uat.sh
sleep 20; /bin/bash /root/pipeline/uat.sh
sleep 25; /bin/bash /root/pipeline/uat.sh
sleep 30; /bin/bash /root/pipeline/uat.sh
sleep 35; /bin/bash /root/pipeline/uat.sh
sleep 40; /bin/bash /root/pipeline/uat.sh
sleep 45; /bin/bash /root/pipeline/uat.sh
sleep 50; /bin/bash /root/pipeline/uat.sh
sleep 55; /bin/bash /root/pipeline/uat.sh


ps -ef | grep 'cron.sh' | grep -v grep | awk '{print $2}' | xargs -r kill -9kill -f
