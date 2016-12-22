import json
import requests
import psycopg2

#http://storm.chordsrt.com/instruments/10.json?last

sensors = {
        'T5':'http://storm.chordsrt.com/instruments/10.json?last',
        'T6':'http://storm.chordsrt.com/instruments/11.json?last',
        'T8':'http://storm.chordsrt.com/instruments/13.json?last',
        'T9':'http://storm.chordsrt.com/instruments/14.json?last',
          }

conn = psycopg2.connect(dbname='xxxxxx',user='xxxxxxxx',password='xxxxxxxx',host='xxx.xxx.xxx.xxx')
curs = conn.cursor()

for device,url in sensors.items():
#print time, value
        #print device,url
	res = requests.get(url)
	jsonResult = json.loads(res.content)
	#last_read_date_query = "select taken_at from public.latest_readings where device_serial = '"+device+"'"
        #curs.execute(last_read_date_query)
	#print curs.fetchall()
	time = jsonResult['Data']['Time'][0]
	value = jsonResult['Data']['depth_sonic'][0]
	update_query = "update latest_readings set taken_at = '"+time+"', current_value="+str(value)+" where device_serial = '"+device+"'" 
	print update_query
	curs.execute(update_query)
	conn.commit()
