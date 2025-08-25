# Air Traffic + Weather Data Pipeline (GCP → MySQL)

**What it does:** A small, serverless-style ETL that fetches 3-hourly weather data and (optionally) joins it with airport arrivals, writing to MySQL. Includes schema + sample data and can run locally.
## Project highlights
- Serverless ingest (Cloud Function Gen2) + scheduled runs (Cloud Scheduler)
- Clean MySQL schema + analytical view `weather_next24h_summary`
- Idempotent inserts (upserts) to avoid duplicates on re-runs
- Local demo path (no GCP required) with `.env` for secrets
- Production-style repo structure (function code, SQL, samples, docs)

## Quickstart (local)
1) Create `function/.env` from `.env.example`.
2) Run `sql/01_schema.sql` in MySQL.
3) `pip install -r function/requirements.txt`
4) `python function/main.py`

## Notes
- No secrets in the repo. Use `.env`.
- Sample data are synthetic.
```mermaid
flowchart LR
  sch[Cloud Scheduler] -->|HTTP| fn[Cloud Function (Gen2)]
  fn --> sql[(Cloud SQL • MySQL)]
  fn --> bkt[(Cloud Storage bucket)]
  subgraph SQL Views
    v1[weather_next24h_summary]
  end
  sql --> v1

4) Click **Commit changes** (commit directly to `main`).  

Reply **next** when it’s saved. If it doesn’t render, I’ll fix the fence/spacing.
