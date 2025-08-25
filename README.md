[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) ![Python](https://img.shields.io/badge/Python-3.12-blue) ![MySQL](https://img.shields.io/badge/DB-MySQL-informational) ![GCP](https://img.shields.io/badge/Cloud-GCP-orange)

## Architecture

```mermaid
flowchart LR
  sch["Cloud Scheduler"] -->|HTTP| fn["Cloud Function Gen2"]
  fn --> sql["Cloud SQL (MySQL)"]
  fn --> bkt["Cloud Storage bucket"]

  subgraph SQL_Views["SQL Views"]
    v1["weather_next24h_summary"]
  end

  sql --> v1

[![Release](https://img.shields.io/github/v/release/amirtalebi58/gans-air-traffic-weather-pipeline)](https://github.com/amirtalebi58/gans-air-traffic-weather-pipeline/releases)  ![Stars](https://img.shields.io/github/stars/amirtalebi58/gans-air-traffic-weather-pipeline?style=social)
