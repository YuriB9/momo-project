# Monitoring cluster using prometheus and grafana

In this instruction, we set up the [prometheus](https://prometheus.io/) metrics collection system and [grafana](https://grafana.com/) visualization system in a managed k8s cluster.

To set up the k8s cluster monitoring system:
* install prometheus.
* configure prometheus.
* configure alertmanager.
* install prometheus-nginx-exporter.
* configure prometheus-nginx-exporter.
* configure ingress-nginx controller.
* install grafana.
* configure grafana.

## Dependencies

* DNS records for prometheus, alertmanager and grafana instances.
* Verified Let’s Encrypt Certificate for domain issued by Yandex Certificate Manager.
* Configured `External Secrets Operator` to sync certificate and coresponding private key with the k8s secret.
* Nginx ingress controller to expose instances to the Internet.
* Exposed metrics from backend and fronted.

## Before you begin

1. Create `monitoring` namespace in k8s cluster.

    ```bash
    kubectl create namespace monitoring
    ```

1. Create label `momo-secret-cert` to propogate secret required for TLS:

    ```bash
    kubectl label namespaces monitoring momo-secret-cert=yc-auth-cert
    ```

## Install prometheus

| Name | Version |
|------|---------|
| APPLICATION VERSION | v2.41.0 |
| CHART VERSIONS | 19.6.1 |


The prometheus monitoring system scans k8s cluster objects and collects their metrics into its own database. The collected metrics are available within the cluster over HTTP.

1. Add a repository containing the prometheus distribution:

   ```bash
   helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
   helm repo update
   ```

1. Install prometheus and alertmanager with preconfigured values:

   ```bash
   helm install --namespace monitoring \
     -f prom-values.yaml \
     -f prom-alerting-rules.yaml \
     -f prom-scrape-config.yaml \
     --set alertmanager.config.receivers[0].telegram_configs[0].bot_token='replace_me' \
     --set alertmanager.config.receivers[0].telegram_configs[0].chat_id=replace_me \
     prometheus prometheus-community/prometheus \
     --version 19.6.1
   ```

1. Make sure that all the pods changed their status to `Running`

## Configure prometheus

The prometheus is available in the cluster at `http://prometheus-server.monitoring.svc.cluster.local`. Grafana will use this URL to collect metrics.

### General configuration within prom-values.yaml :

The prometheus might be exposed to the Internet (disabled by default) by enabling ingress:
```yaml
ingress:
  enabled: true
...
```

Url to access the prometheus web ui: https://prometheus.btkv.tech

Services below are disabled:
* kube-state-metrics
* prometheus-node-exporter
* prometheus-pushgateway

### Scrape configuration within prom-scrape-config.yaml :

* Enable static config for `frontend-nginx-exporter`.
* Enable service discovery for pods in `momo-app` namespace only.

### Alerting rules configuration within prom-alerting-rules.yaml :

* Use this yaml file to specify new and configure existent rules to generate an alert.

## Configure alertmanager

The alertmanager is available in the cluster at `http://alertmanager.monitoring.svc.cluster.local`.

The alertmanager might be exposed to the Internet (disabled by default) by enabling ingress in `prom-values.yaml`:
```yaml
ingress:
  enabled: true
...
```

Url to access the prometheus web ui: https://alertmanager.btkv.tech
See more details: https://artifacthub.io/packages/helm/prometheus-community/prometheus

### Telegram Receiver configuration within prom-values.yaml :

* Use this yaml file to configure receiver and route.

## Install prometheus-nginx-exporter.

| Name | Version |
|------|---------|
| APPLICATION VERSION | 0.11.0 |
| CHART VERSIONS | 0.1.0 |

NGINX Prometheus exporter makes it possible to monitor NGINX web server using Prometheus.

1. Add a repository containing the prometheus distribution:

   ```bash
   helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
   helm repo update
   ```

1. Install prometheus-nginx-exporter with preconfigured values:

   ```bash
   helm install --namespace monitoring \
     -f frontend-nginx-values.yaml \
     frontend prometheus-community/prometheus-nginx-exporter \
     --version 0.1.0
   ```

1. Make sure that all the pods changed their status to `Running`

## Configure prometheus-nginx-exporter within frontend-nginx-values.yaml :

The prometheus-nginx-exporter is pointed to local `frontend-service` in `momo-app` namespace. Service should already expose `metrics` on desired port (Configured by stub_status in nginx-service.conf)

See more details: https://artifacthub.io/packages/helm/prometheus-community/prometheus-nginx-exporter

## Configure ingress-nginx controller.

`ingress-nginx` controller should already exist as a part of `momo-app` application.

1. Enable metrics for prometheus scrap (use `correct` namespace!!):

   ```bash
   helm upgrade \
     --set controller.metrics.enabled=true \
     --set-string controller.podAnnotations."prometheus\.io/scrape"="true" \
     --set-string controller.podAnnotations."prometheus\.io/port"="10254" \
     ingress-nginx ingress-nginx/ingress-nginx
   ```

See more details: https://artifacthub.io/packages/helm/ingress-nginx/ingress-nginx

## Install grafana

| Name | Version |
|------|---------|
| APPLICATION VERSION | 9.3.6 |
| CHART VERSIONS | 6.50.8 |

When deploying the application, the following will be created:
* Grafana application `Deployment`.
* `PersistentVolumeClaim` to reserve internal storage.

1. Add a repository containing the grafana distribution:

   ```bash
   helm repo add grafana https://grafana.github.io/helm-charts
   helm repo update
   ```

1. Install grafana with preconfigured values:

   ```bash
   helm install --namespace monitoring \
     -f grafana-values.yaml \
     grafana grafana/grafana \
     --version 6.50.8
   ```

1. Make sure that all the pods changed their status to `Running`

## Configure grafana

The grafana is available in the cluster at `http://grafana.monitoring.svc.cluster.local`.

The grafana is exposed to the Internet by default.
Url to access the grafana web ui: https://grafana.btkv.tech

See more details: https://artifacthub.io/packages/helm/grafana/grafana

### Predefined configuration within grafana-values.yaml :

* Defined prometheus datasource pointed to local prometheus-server.
* Defined default dashboard provider.
* Defined 2 dashboards with id 12708 and id 9614.

1. Open the dashboard and make sure that grafana receives metrics from the  managed k8s cluster.