#!/usr/bin/python3


import os
import configparser 
import oandapy as opy
import pandas as pd
import numpy as np

config = configparser.ConfigParser()  # 3
config.read('/etc/OANDA/config/oanda.cfg')  # 4

oanda = opy.API(environment='practice',
                            access_token=config['oanda']['access_token'])  # 5

data = oanda.get_history(instrument='EUR_USD',  # our instrument
                                 start='2018-04-03',  # start data
                                                          end='2018-04-06',  # end date
                                                                                   granularity='M1')  # minute bars  # 7

df = pd.DataFrame(data['candles']).set_index('time')  # 8

df.index = pd.DatetimeIndex(df.index)  # 9

df.info() # 10



df['returns'] = np.log(df['closeAsk'] / df['closeAsk'].shift(1))  # 12

cols = []  # 13

for momentum in [15, 30, 60, 120]:  # 14
    col='position_%s' % momentum  # 15
df[col] = np.sign(df['returns'].rolling(momentum).mean())  # 16
cols.append(col)  # 17
print(df)

