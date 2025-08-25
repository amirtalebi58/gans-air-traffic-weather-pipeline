-- Create schema if not exists
CREATE DATABASE IF NOT EXISTS test_schema;
USE test_schema;

-- Weather forecast (3-hour slots)
CREATE TABLE IF NOT EXISTS weather_forecast_3h (
  city_name        VARCHAR(100) NOT NULL,
  country_code     CHAR(2)      NOT NULL,
  ts_utc           DATETIME     NOT NULL,
  temp             DECIMAL(5,2) NULL,
  feels_like       DECIMAL(5,2) NULL,
  pressure         INT          NULL,
  humidity         INT          NULL,
  wind_speed       DECIMAL(5,2) NULL,
  wind_deg         INT          NULL,
  wind_gust        DECIMAL(5,2) NULL,
  clouds           INT          NULL,
  pop              DECIMAL(5,2) NULL,  -- probability of precipitation (0..1)
  rain_3h          DECIMAL(5,2) NULL,
  snow_3h          DECIMAL(5,2) NULL,
  PRIMARY KEY (city_name, country_code, ts_utc),
  INDEX idx_city_ts (city_name, ts_utc)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Daily airport ops + weather roll-up
CREATE TABLE IF NOT EXISTS airport_ops_weather_daily (
  airport_icao        VARCHAR(4)  NOT NULL,
  date_local          DATE        NOT NULL,
  total_arrivals      INT         NOT NULL,
  physical_arrivals   INT         NOT NULL,
  peak_hour_local     VARCHAR(5)  NULL,
  peak_hour_flights   INT         NULL,
  top_airlines        TEXT        NULL,
  top_origins         TEXT        NULL,
  wx_snapshot_utc     DATETIME    NULL,
  min_temp_c          DECIMAL(5,2) NULL,
  max_temp_c          DECIMAL(5,2) NULL,
  PRIMARY KEY (airport_icao, date_local)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
