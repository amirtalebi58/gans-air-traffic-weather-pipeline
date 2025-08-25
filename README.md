## Architecture

```mermaid
flowchart LR
  sch[Cloud Scheduler] -->|HTTP| fn[Cloud Function Gen2]
  fn --> sql[Cloud SQL (MySQL)]
  fn --> bkt[Cloud Storage bucket]
  subgraph "SQL Views"
    v1[weather_next24h_summary]
  end
  sql --> v1

  
