
#!/bin/bash

current_date_time="`date +%Y-%m-%d/%H:%M`";
echo "$current_date_time" >> /root/pipeline/log_wc_bid


wc -l /root/pipeline/uat_stream/ff33_.csv >> /root/pipeline/log_wc_bid

wc-l /root/pipeline/uat_stream/ff33_.csv >> /root/pipeline/log_wc_bid2

