# frontend

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![AppVersion: 0.1.0](https://img.shields.io/badge/AppVersion-0.1.0-informational?style=flat-square)

A Frontend Helm chart for Kubernetes

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| autoscaling.enabled | bool | `false` | Enable Horizontal Pod Autoscaler for the repo server |
| autoscaling.maxReplicas | int | `2` | Maximum number of replicas for the repo server |
| autoscaling.minReplicas | int | `1` | Minimum number of replicas for the repo server |
| imagePullSecrets | list | `[{"name":"momo-cr-lockbox"}]` | Global image pull secrets |
| livenessProbe.failureThreshold | int | `6` | Minimum consecutive failures for the probe to be considered failed after having succeeded |
| livenessProbe.httpGet.path | string | `"/"` |  |
| livenessProbe.httpGet.port | int | `80` |  |
| livenessProbe.initialDelaySeconds | int | `15` | Number of seconds after the container has started before probe is initiated |
| livenessProbe.periodSeconds | int | `30` | How often (in seconds) to perform the probe |
| livenessProbe.timeoutSeconds | int | `1` | Number of seconds after which the probe times out |
| podAnnotations | object | `{}` | Pod Annotations for the deployment |
| readinessProbe | object | `{}` |  |
| replicaCount | int | `1` | The number of pods to run |
| resources | object | `{"limits":{"cpu":"500m","memory":"128Mi"},"requests":{"cpu":"250m","memory":"64Mi"}}` | Pod memory and cpu resource settings for the deployment |
| service.port | int | `80` | Kubernetes port where service is exposed |
| service.type | string | `"ClusterIP"` | Kubernetes service type |
| strategy | object | `{"type":"Recreate"}` | The deployment strategy to use to replace existing pods with new ones |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
