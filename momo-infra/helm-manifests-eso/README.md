# Secret management using External Secrets Operator

The External Secrets Operator syncs the certificate with the Kubernetes secret. This helps control the deployed application's certificate via Certificate Manager by importing a self-signed certificate and updating it on your own or by issuing a Let's Encrypt® certificate that will update automatically.

To enable secret management:
* install External Secrets Operator.
* create generic secret with auth key for service account.
* create cluster-secret-store-cert.
* create cluster-external-secret-cert.

## Dependencies

* Verified Let’s Encrypt Certificate for domain issued by Yandex Certificate Manager.
* Service Account `yb-cert-sa` with Auth key to download certificate.
* Service Account `yb-lockbox-sa` with Auth key to view Lockbox secrets.


## Before you begin

1. Create `external-secrets` namespace in k8s cluster.

    ```bash
    kubectl create namespace external-secrets
    ```

1. Create an authorized key for the `yb-cert-sa` service account and save it to the file `authorized-key-cert.json`:

    ```bash
    yc iam key create \
      --service-account-name yb-cert-sa \
      --output authorized-key-cert.json
    ```

1. Create an authorized key for the `yb-lockbox-sa` service account and save it to the file `authorized-key-lockbox.json`:

    ```bash
    yc iam key create \
      --service-account-name yb-lockbox-sa \
      --output authorized-key-lockbox.json
    ```

## Install External Secrets Operator

| Name | Version |
|------|---------|
| APPLICATION VERSION | v0.7.2 |
| CHART VERSIONS | 0.7.2 |


External-secrets runs within your Kubernetes cluster as a deployment resource. It utilizes CustomResourceDefinitions to configure access to secret providers through SecretStore resources and manages Kubernetes secret resources with ExternalSecret resources.

1. Add a repository containing the ESO distribution:

   ```bash
   helm repo add external-secrets https://charts.external-secrets.io
   helm repo update
   ```

1. Install ESO:

   ```bash
   helm install --namespace external-secrets \
    --set installCRDs=true
    external-secrets external-secrets/external-secrets \
    --version 0.7.2
   ```

1. Make sure that all the pods changed their status to `Running`

See more details: https://artifacthub.io/packages/helm/external-secrets-operator/external-secrets

## Create `yc-auth-cert` generic secret with auth key for service account

1. Create a `yc-auth-cert` secret with the `yb-cert-sa` key.

    ```bash
    kubectl --namespace external-secrets \
      create secret generic yc-auth-cert \
      --from-file=authorized-key=authorized-key-cert.json
    ```

## Create cluster-secret-store-cert

1. Create a ClusterSecretStore called `cluster-secret-store-cert` containing a secret named `yc-auth-cert`.

    ```bash
    kubectl --namespace external-secrets apply -f cluster-secret-store-cert.yaml
    ```

## Create cluster-external-secret-cert

1. Create an ClusterExternalSecret object named `cluster-external-secret-cert` pointing to the certificate from Certificate Manager.

    ```bash
    kubectl --namespace external-secrets apply -f cluster-external-secret-cert.yaml
    ```

`momo-main-cert` with TLS certificate and private key will be installed as secret to every namespace labeled as below:

```yaml
  namespaceSelector:
    matchLabels:
      momo-secret-cert: yc-auth-cert
```

## Create `yc-auth-lockbox` generic secret with auth key for service account

1. Create a `yc-auth-lockbox` secret with the `yb-lockbox-sa` key.

    ```bash
    kubectl --namespace external-secrets \
      create secret generic yc-auth-lockbox \
      --from-file=authorized-key=authorized-key-lockbox.json
    ```

## Create cluster-secret-store-lockbox

1. Create a ClusterSecretStore called `cluster-secret-store-lockbox` containing a secret named `yc-auth-lockbox`.

    ```bash
    kubectl --namespace external-secrets apply -f cluster-secret-store-lockbox.yaml
    ```

## Create cluster-external-secret-infra-lockbox

1. Create an ClusterExternalSecret object named `cluster-external-secret-infra-lockbox` pointing to the secrets from Lockbox.

    ```bash
    kubectl --namespace external-secrets apply -f cluster-external-secret-infra-lockbox.yaml
    ```

`momo-infra-lockbox` with username, url and token from infra repo will be installed as secret to every namespace labeled as below:

```yaml
  namespaceSelector:
    matchLabels:
      momo-secret-infra-lockbox: yc-auth-lockbox
```

## Create cluster-external-secret-app-lockbox

1. Create an ClusterExternalSecret object named `cluster-external-secret-app-lockbox` pointing to the secrets from Lockbox.

    ```bash
    kubectl --namespace external-secrets apply -f cluster-external-secret-app-lockbox.yaml
    ```

`momo-app-lockbox` with username, url and token from app repo will be installed as secret to every namespace labeled as below:

```yaml
  namespaceSelector:
    matchLabels:
      momo-secret-app-lockbox: yc-auth-lockbox
```

## Create cluster-external-secret-cr-lockbox

1. Create an ClusterExternalSecret object named `cluster-external-secret-cr-lockbox` pointing to the secrets from Lockbox.

    ```bash
    kubectl --namespace external-secrets apply -f cluster-external-secret-cr-lockbox.yaml
    ```

`momo-cr-lockbox` with dockerconfigjson to access container registry will be installed as secret to every namespace labeled as below:

```yaml
  namespaceSelector:
    matchLabels:
      momo-secret-cr-lockbox: yc-auth-lockbox
```
