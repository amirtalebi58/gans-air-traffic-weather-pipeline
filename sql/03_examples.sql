-- 1) Check next 24h coverage and rain probability
USE test_schema;
SELECT * FROM weather_next24h_summary ORDER BY max_pop_pct DESC;

-- 2) Example: recent daily ops with temps (if you’ve loaded airport_ops_weather_daily)
SELECT
  a.airport_icao,
  a.date_local,
  a.total_arrivals,
  a.min_temp_c, a.max_temp_c
FROM airport_ops_weather_daily a
WHERE a.date_local >= CURDATE() - INTERVAL 7 DAY
ORDER BY a.date_local DESC, a.airport_icao;
