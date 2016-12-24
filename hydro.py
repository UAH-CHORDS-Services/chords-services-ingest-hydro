import json
import logging
import requests
import psycopg2

sensors = {
    'T5': 'http://storm.chordsrt.com/instruments/10.json?last',
    'T6': 'http://storm.chordsrt.com/instruments/11.json?last',
    'T8': 'http://storm.chordsrt.com/instruments/13.json?last',
    'T9': 'http://storm.chordsrt.com/instruments/14.json?last',
}
logging.debug('sensors: %s', repr(sensors))

conn = psycopg2.connect('')
logging.debug('conn: %s', repr(conn))

curs = conn.cursor()
logging.debug('curs: %s', repr(curs))

for device, url in sensors.items():
    logging.debug('device, url: %s, %s', repr(device), repr(url))
    res = requests.get(url)
    logging.debug('res: %s', repr(res))
    jsonResult = json.loads(res.content)
    logging.debug('jsonResult: %s', repr(jsonResult))
    time = jsonResult['Data']['Time'][0]
    value = jsonResult['Data']['depth_sonic'][0]
    logging.debug('time, value: %s, %s', repr(time), repr(value))
    update_query = "update latest_readings set taken_at = %s, current_value = %s where device_serial = %s"
    curs.execute(update_query, (time, value, device))
    conn.commit()
