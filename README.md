# Tea4Life Observability

Prometheus config for scraping Tea4Life backend metrics.

## Dokploy deployment

1. Bind this repository as a Docker Compose app in Dokploy.
2. Make sure the external Docker network in `docker-compose.yml` exists:

   ```yaml
   tea4life-backend-network
   ```

3. Attach these services to that same network:

   - `order-service`
   - `product-service`
   - `user-service`
   - `prometheus`

4. Deploy the compose app.
5. Open Prometheus target health:

   ```text
   https://prometheus.tea4life.click/targets
   ```

All three scrape targets should be `UP`.

If the backend network has a different name on Dokploy, update `docker-compose.yml` before deploying.
