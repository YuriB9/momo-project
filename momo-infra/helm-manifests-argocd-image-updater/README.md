## Before you begin

1. Install argocd first (See helm-manifests-argocd)

## Install argocd-image-updater

| Name | Version |
|------|---------|
| APPLICATION VERSION | v0.12.2 |
| CHART VERSIONS | 0.8.4 |

Argocd Image Updater - tool to automatically update the container images of Kubernetes workloads which are managed by Argo CD.

1. Add a repository containing the argocd iu distribution:

   ```bash
   helm repo add argo https://argoproj.github.io/argo-helm
   helm repo update
   ```

1. Install argocd with preconfigured values:

   ```bash
   helm install --namespace argocd
     -f argocd-iu-values.yaml \
     argocd-image-updater argo/argocd-image-updater \
     --version 0.8.4
   ```

1. Make sure that all the pods changed their status to `Running`