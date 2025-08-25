import os
import json
import datetime as dt
import pymysql
from dotenv import load_dotenv

load_dotenv()

DB_HOST = os.getenv("DB_HOST", "localhost")
DB_PORT = int(os.getenv("DB_PORT", "3306"))
DB_USER = os.getenv("DB_USER", "root")
DB_PASS = os.getenv("DB_PASS", "")
DB_NAME = os.getenv("DB_NAME", "test_schema")

def get_db_conn():
    return pymysql.connect(
        host=DB_HOST, port=DB_PORT, user=DB_USER, password=DB_PASS,
        database=DB_NAME, autocommit=True, charset="utf8mb4",
        cursorclass=pymysql.cursors.DictCursor
    )

def ensure_tzaware(ts: dt.datetime) -> dt.datetime:
    if ts.tzinfo:
        return ts.astimezone(dt.timezone.utc).replace(tzinfo=None)
    return ts

def insert_sample_weather():
    rows = [
        {"city_name":"Berlin","country_code":"DE",
         "ts_utc":dt.datetime.utcnow().replace(minute=0, second=0, microsecond=0),
         "temp":24.3,"feels_like":24.1,"pressure":1015,"humidity":55,
         "wind_speed":3.5,"wind_deg":210,"wind_gust":6.0,"clouds":40,
         "pop":0.20,"rain_3h":0.0,"snow_3h":0.0},
        {"city_name":"Berlin","country_code":"DE",
         "ts_utc":dt.datetime.utcnow().replace(minute=0, second=0, microsecond=0)+dt.timedelta(hours=3),
         "temp":22.1,"feels_like":22.0,"pressure":1016,"humidity":60,
         "wind_speed":3.0,"wind_deg":200,"wind_gust":5.0,"clouds":50,
         "pop":0.35,"rain_3h":0.2,"snow_3h":0.0},
    ]
    sql = """
    INSERT INTO weather_forecast_3h
    (city_name, country_code, ts_utc, temp, feels_like, pressure, humidity, wind_speed, wind_deg, wind_gust, clouds, pop, rain_3h, snow_3h)
    VALUES
    (%(city_name)s, %(country_code)s, %(ts_utc)s, %(temp)s, %(feels_like)s, %(pressure)s, %(humidity)s, %(wind_speed)s, %(wind_deg)s, %(wind_gust)s, %(clouds)s, %(pop)s, %(rain_3h)s, %(snow_3h)s)
    ON DUPLICATE KEY UPDATE
      temp=VALUES(temp), feels_like=VALUES(feels_like), pressure=VALUES(pressure), humidity=VALUES(humidity),
      wind_speed=VALUES(wind_speed), wind_deg=VALUES(wind_deg), wind_gust=VALUES(wind_gust),
      clouds=VALUES(clouds), pop=VALUES(pop), rain_3h=VALUES(rain_3h), snow_3h=VALUES(snow_3h);
    """
    with get_db_conn() as conn, conn.cursor() as cur:
        for r in rows:
            r["ts_utc"] = ensure_tzaware(r["ts_utc"])
            cur.execute(sql, r)
    return len(rows)

def handler(request=None):
    inserted = insert_sample_weather()
    payload = {"status":"ok","inserted_rows":inserted}
    if request is None:
        return payload
    return (json.dumps(payload), 200, {"Content-Type":"application/json"})

if __name__ == "__main__":
    print(json.dumps(handler()))
