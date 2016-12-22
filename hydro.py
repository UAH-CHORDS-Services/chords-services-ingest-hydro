import json
import requests
import psycopg2

sensors = {
    'T5': 'http://storm.chordsrt.com/instruments/10.json?last',
    'T6': 'http://storm.chordsrt.com/instruments/11.json?last',
    'T8': 'http://storm.chordsrt.com/instruments/13.json?last',
    'T9': 'http://storm.chordsrt.com/instruments/14.json?last',
}

conn = psycopg2.connect(dbname='xxxxxx', user='xxxxxxxx',
                        password='xxxxxxxx', host='xxx.xxx.xxx.xxx')
curs = conn.cursor()

for device, url in sensors.items():
    res = requests.get(url)
    jsonResult = json.loads(res.content)
    time = jsonResult['Data']['Time'][0]
    value = jsonResult['Data']['depth_sonic'][0]
    update_query = "update latest_readings set taken_at = %s" + \
        ", current_value = %s" + \
        " where device_serial = %s"
    curs.execute(update_query, (time, value, device))
    conn.commit()
