# Tea4Life Observability

Prometheus and Grafana config for Tea4Life backend metrics.

## Dokploy deployment

1. Bind this repository as a Docker Compose app in Dokploy.
2. Make sure the external Docker network in `docker-compose.yml` exists:

   ```yaml
   tea4life-backend-network
   ```

3. Attach these backend services to that same network:

   - `order-service`
   - `product-service`
   - `user-service`

4. Deploy the compose app.
5. Add domains in Dokploy:

   - Prometheus: container port `9090`
   - Grafana: container port `3000`

6. Open Prometheus target health:

   ```text
   https://prometheus.tea4life.click/targets
   ```

All three scrape targets should be `UP`.

7. Open Grafana and log in with the configured credentials:

   ```text
   https://grafana.tea4life.click
   ```

By default, Grafana uses:

```text
admin / admin
```

Set `GRAFANA_ADMIN_USER` and `GRAFANA_ADMIN_PASSWORD` in Dokploy environment variables for production.

Grafana is provisioned with a default Prometheus datasource at:

```text
http://prometheus:9090
```

Grafana also provisions three service dashboards in the `Tea4Life` folder:

- Tea4Life Order Service
- Tea4Life Product Service
- Tea4Life User Service

Each dashboard contains the requested 11 panels:

- Service Up
- Requests / sec
- Error Rate
- JVM Memory Used
- API Throughput by Status
- Response Time p50 / p95 / p99
- Slowest URI p95
- Top URI Request Rate
- JVM Memory by Area
- HikariCP Connections
- CPU Usage

If the backend network has a different name on Dokploy, update `docker-compose.yml` before deploying.
