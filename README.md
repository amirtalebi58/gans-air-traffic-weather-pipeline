## Architecture
## Sample query result

![Demo query](architecture/demo_query.png)


```mermaid
flowchart LR
  sch["Cloud Scheduler"] -->|HTTP| fn["Cloud Function Gen2"]
  fn --> sql["Cloud SQL (MySQL)"]
  fn --> bkt["Cloud Storage bucket"]

  subgraph SQL_Views["SQL Views"]
    v1["weather_next24h_summary"]
  end

  sql --> v1
```
[![Release](https://img.shields.io/github/v/release/amirtalebi58/gans-air-traffic-weather-pipeline)](https://github.com/amirtalebi58/gans-air-traffic-weather-pipeline/releases)  ![Stars](https://img.shields.io/github/stars/amirtalebi58/gans-air-traffic-weather-pipeline?style=social)

