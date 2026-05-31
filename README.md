# Tea4Life Observability

Prometheus and Grafana config for Tea4Life backend metrics.

## Dokploy deployment

1. Bind this repository as a Docker Compose app in Dokploy.
2. Configure these required environment variables in Dokploy:

   ```text
   ORDER_METRICS_URL=https://api.tea4life.click/order-service/actuator/prometheus
   PRODUCT_METRICS_URL=https://api.tea4life.click/product-service/actuator/prometheus
   USER_METRICS_URL=https://api.tea4life.click/user-service/actuator/prometheus
   ```

3. Deploy the compose app.
4. Add domains in Dokploy:

   - Prometheus: container port `9090`
   - Grafana: container port `3000`

The compose file uses `expose` instead of host `ports` to avoid conflicts with existing Grafana or Prometheus containers on the Dokploy server.

5. Open Prometheus target health:

   ```text
   https://prometheus.tea4life.click/targets
   ```

All three scrape targets should be `UP`.

6. Open Grafana and log in with the configured credentials:

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
