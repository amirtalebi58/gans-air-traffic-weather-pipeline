# Scheduler cron (when deployed on GCP)

Every 3 hours:
0 */3 * * *

Region: europe-west1   (change to your region if needed)
Target: HTTP-triggered Cloud Function (Gen2)
Notes: Use a service account with least-privilege to call the function.
