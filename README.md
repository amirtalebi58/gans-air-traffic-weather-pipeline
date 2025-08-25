# Air Traffic + Weather Data Pipeline (GCP → MySQL)

**What it does:** A small, serverless-style ETL that fetches 3-hourly weather data and (optionally) joins it with airport arrivals, writing to MySQL. Includes schema + sample data and can run locally.

## Quickstart (local)
1) Create `function/.env` from `.env.example`.
2) Run `sql/01_schema.sql` in MySQL.
3) `pip install -r function/requirements.txt`
4) `python function/main.py`

## Notes
- No secrets in the repo. Use `.env`.
- Sample data are synthetic.
