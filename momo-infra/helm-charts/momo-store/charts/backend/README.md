# backend

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![AppVersion: 0.1.0](https://img.shields.io/badge/AppVersion-0.1.0-informational?style=flat-square)

A Backend Helm chart for Kubernetes

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| autoscaling.enabled | bool | `false` | Enable Horizontal Pod Autoscaler for the repo server |
| autoscaling.maxReplicas | int | `3` | Maximum number of replicas for the repo server |
| autoscaling.minReplicas | int | `2` | Minimum number of replicas for the repo server |
| imagePullSecrets | list | `[{"name":"momo-cr-lockbox"}]` | Global image pull secrets |
| livenessProbe.failureThreshold | int | `6` | Minimum consecutive failures for the probe to be considered failed after having succeeded |
| livenessProbe.initialDelaySeconds | int | `15` | Number of seconds after the container has started before probe is initiated |
| livenessProbe.periodSeconds | int | `30` | How often (in seconds) to perform the probe |
| livenessProbe.tcpSocket.port | int | `8081` |  |
| livenessProbe.timeoutSeconds | int | `2` | Number of seconds after which the probe times out |
| podAnnotations | object | `{"prometheus.io/path":"/metrics","prometheus.io/port":"8081","prometheus.io/scrape":"true"}` | Pod Annotations for the deployment |
| replicaCount | int | `1` | The number of pods to run |
| resources | object | `{"limits":{"cpu":"1000m","memory":"512Mi"},"requests":{"cpu":"500m","memory":"256Mi"}}` | Pod memory and cpu resource settings for the deployment |
| service.port | int | `8081` | Kubernetes port where service is exposed |
| service.type | string | `"ClusterIP"` | Kubernetes service type |
| strategy | object | `{"rollingUpdate":{"maxSurge":"20%","maxUnavailable":1},"type":"RollingUpdate"}` | The deployment strategy to use to replace existing pods with new ones |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
