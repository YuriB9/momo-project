
## Before you begin

1. Create `argocd` namespace in k8s cluster.

    ```bash
    kubectl create namespace argocd
    ```

1. Create label `momo-secret-infra-lockbox` to propogate secret required to auth to `infra` repo:

    ```bash
    kubectl label namespaces argocd momo-secret-infra-lockbox=yc-auth-lockbox
    ```

1. Create label `momo-secret-app-lockbox` to propogate secret required to auth to `app` repo:

    ```bash
    kubectl label namespaces argocd momo-secret-app-lockbox=yc-auth-lockbox
    ```
1. Create label `momo-secret-cr-lockbox` to propogate `dockerconfigjson` secret required for argocd-image-updater:

    ```bash
    kubectl label namespaces argocd momo-secret-cr-lockbox=yc-auth-lockbox
    ```
1. Create label `momo-secret-cert` to propogate secret required for TLS certificate:

    ```bash
    kubectl label namespaces argocd momo-secret-cert=yc-auth-cert
    ```

## Install argocd

| Name | Version |
|------|---------|
| APPLICATION VERSION | v2.6.2 |
| CHART VERSIONS | 5.23.1 |

Argocd, a declarative, GitOps continuous delivery tool for Kubernetes.

1. Add a repository containing the argocd distribution:

   ```bash
   helm repo add argo https://argoproj.github.io/argo-helm
   helm repo update
   ```

1. Install argocd with preconfigured values:

   ```bash
   helm install --namespace argocd \
     -f argocd-values.yaml \
     momo-argo-cd argo/argo-cd \
     --version 5.23.1
   ```

1. Make sure that all the pods changed their status to `Running`

1. Deploy `momo-infra-project` argocd project:

   ```bash
   kubectl apply --namespace argocd -f argocd-project.yaml
   ```

1. Deploy `momo-application-set` argocd application set:

   ```bash
   kubectl apply --namespace argocd -f argocd-application-set.yaml
   ```