#!/bin/sh
set -eu

parse_url() {
  prefix="$1"
  url="$2"

  scheme="${url%%://*}"
  rest="${url#*://}"
  host="${rest%%/*}"

  if [ "$host" = "$rest" ]; then
    path="/metrics"
  else
    path="/${rest#*/}"
  fi

  eval "${prefix}_SCHEME=\$scheme"
  eval "${prefix}_HOST=\$host"
  eval "${prefix}_PATH=\$path"
}

parse_url ORDER "$ORDER_METRICS_URL"
parse_url PRODUCT "$PRODUCT_METRICS_URL"
parse_url USER "$USER_METRICS_URL"

sed \
  -e "s|__ORDER_SCHEME__|$ORDER_SCHEME|g" \
  -e "s|__ORDER_HOST__|$ORDER_HOST|g" \
  -e "s|__ORDER_PATH__|$ORDER_PATH|g" \
  -e "s|__PRODUCT_SCHEME__|$PRODUCT_SCHEME|g" \
  -e "s|__PRODUCT_HOST__|$PRODUCT_HOST|g" \
  -e "s|__PRODUCT_PATH__|$PRODUCT_PATH|g" \
  -e "s|__USER_SCHEME__|$USER_SCHEME|g" \
  -e "s|__USER_HOST__|$USER_HOST|g" \
  -e "s|__USER_PATH__|$USER_PATH|g" \
  /etc/prometheus/prometheus.yml.template > /tmp/prometheus.yml

exec /bin/prometheus \
  --config.file=/tmp/prometheus.yml \
  --storage.tsdb.path=/prometheus \
  --web.enable-lifecycle
