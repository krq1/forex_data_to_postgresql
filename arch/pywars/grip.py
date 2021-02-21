#!/usr/bin/python
import psycopg2


try:

    conn = psycopg2.connect("dbname='forex' user='postgres' host='localhost' password='mlekomleko6'")
except:
    print "I am unable to connect to the database"

