USE test_schema;

DROP VIEW IF EXISTS weather_next24h_summary;
CREATE VIEW weather_next24h_summary AS
SELECT
  wf.city_name,
  wf.country_code AS country,
  UTC_TIMESTAMP() AS horizon_start_utc,
  (UTC_TIMESTAMP() + INTERVAL 24 HOUR) AS horizon_end_utc,
  COUNT(*) AS slots_3h,
  MIN(wf.ts_utc) AS first_ts_utc,
  MAX(wf.ts_utc) AS last_ts_utc,
  ROUND(100 * MAX(COALESCE(wf.pop,0)), 1) AS max_pop_pct,
  ROUND(SUM(COALESCE(wf.rain_3h,0)), 2) AS total_rain_mm
FROM weather_forecast_3h wf
WHERE wf.ts_utc BETWEEN UTC_TIMESTAMP() AND (UTC_TIMESTAMP() + INTERVAL 24 HOUR)
GROUP BY wf.city_name, wf.country_code;
