#!/bin/bash

sudo curl --request GET 'https://webrates.truefx.com/rates/connect.html?c=EUR/USD&f=csv&s=n' >> /root/pipeline/e.csv
sudo curl --request GET 'https://webrates.truefx.com/rates/connect.html?c=EUR/USD&f=csv&s=n' >> /root/pipeline/ee.csv
sudo curl --request GET 'https://webrates.truefx.com/rates/connect.html?c=EUR/USD&f=csv&s=n' >> /root/pipeline/eee.csv
sudo curl --request GET 'https://webrates.truefx.com/rates/connect.html?c=EUR/USD&f=csv&s=n' >> /root/pipeline/eeee.csv
sudo curl --request GET 'https://webrates.truefx.com/rates/connect.html?c=EUR/USD&f=csv&s=n' >> /root/pipeline/eeeee.csv



#for run in {1..99999999999999999999999999999999999999999999999999999999}
#do
#bash /root/pipeline/dwn.sh
#done




#bash /root/pipeline/dwn.sh
