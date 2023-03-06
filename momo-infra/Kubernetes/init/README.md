# Creating a static configuration file

Static configuration files let you access a k8s cluster without using the CLI.

## Before you begin

Create `momo-app` namespace in k8s cluster.

## Get a unique k8s cluster ID

Here and below we will use PowerShell (why not?)

1. Find the unique ID of the k8s cluster:

    ```bash
    yc managed-kubernetes cluster list
    ```

1. Save the unique ID of the k8s cluster to a variable.

    ```shell script
    $CLUSTER_ID = "cath38nn5nofrosqcq66"
    ```

## Prepare the cluster certificate

1. Get detailed information about the k8s cluster in JSON format and save it to the `$CLUSTER` variable:

    ```shell script
    $CLUSTER = yc managed-kubernetes cluster get --id $CLUSTER_ID --format json | ConvertFrom-Json
    ```

1. Get the k8s cluster certificate and save it to the `ca.pem` file:

    ```shell script
    $CLUSTER.master.master_auth.cluster_ca_certificate | Set-Content ca.pem
    ```

## Create a ServiceAccount object

1. Create a `ServiceAccount` object to interact with the k8s API inside the k8s cluster.

    ```yaml
    apiVersion: v1
    kind: ServiceAccount
    metadata:
        name: gitlab-admin
        namespace: kube-system
    ---
    apiVersion: rbac.authorization.k8s.io/v1
    kind: ClusterRoleBinding
    metadata:
        name: gitlab-admin
    roleRef:
        apiGroup: rbac.authorization.k8s.io
        kind: ClusterRole
        name: cluster-admin
    subjects:
    - kind: ServiceAccount
        name: gitlab-admin
        namespace: kube-system
    ```

1. Create a `ServiceAccount` object.

   ```bash
   kubectl create -f admin-service-account.yaml
   ```

## Prepare a ServiceAccount token

1. Get the `ServiceAccount` token. Quotation marks in its contents will be removed automatically:

    ```shell script
    $SECRET = kubectl -n kube-system get secret -o json | `
      ConvertFrom-Json | `
      Select-Object -ExpandProperty items | `
      Where-Object { $_.metadata.name -like "*gitlab-admin*" }
    ```

1. Decode the token from Base64:

    ```shell script
    $SA_TOKEN = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($SECRET.data.token))
    ```

## Get the cluster's IP address

1. Get the k8s cluster IP and add it to the `MASTER_ENDPOINT` variable for further use.

    ```shell script
    $MASTER_ENDPOINT = $CLUSTER.master.endpoints.external_v4_endpoint
    ```

## Create and populate a configuration file

1. Add information about the k8s cluster to the configuration file.

    ```bash
    kubectl config set-cluster k8s-cluster `
      --embed-certs `
      --certificate-authority=ca.pem `
      --server=$MASTER_ENDPOINT `
      --kubeconfig=gitlab.kubeconfig
    ```

1. Add token information for `gitlab-admin` to the configuration file.

    ```shell script
    kubectl config set-credentials gitlab-admin `
      --token=$SA_TOKEN `
      --kubeconfig=gitlab.kubeconfig
    ```

1. Add context information to the configuration file.

    ```shell script
    kubectl config set-context default `
      --cluster=k8s-cluster `
      --user=gitlab-admin `
      --namespace=momo-app `
      --kubeconfig=gitlab.kubeconfig
    ```

1. Use the created configuration for further work.

    ```shell script
    kubectl config use-context default `
      --kubeconfig=gitlab.kubeconfig
    ```
