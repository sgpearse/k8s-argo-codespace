# k8s-argo-codespace
Provide a preconfigured codespace that can be launched in VSCode locally that contains k8s, argo, and other tools to learn

## Overview
Open this repo in Codespaces and then open it in VSCode desktop to launch a Kubernetes cluster to install apps and play with.

## Install Argo CD

```
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

Wait until all the pods in the argocd namespace are up and running before proceeding to the next steps

```
kubectl get pods -n argocd
```

When successful it will look like this:

```
/workspaces/k8s-argo-codespace (main) $ kubectl get pods -n argocd
NAME                                                READY   STATUS    RESTARTS   AGE
argocd-application-controller-0                     1/1     Running   0          8m43s
argocd-applicationset-controller-7c77597d54-5qt76   1/1     Running   0          8m44s
argocd-dex-server-5d86b78484-tvbjh                  1/1     Running   0          8m44s
argocd-notifications-controller-78f5bf5947-l2g57    1/1     Running   0          8m43s
argocd-redis-757c9855f5-ssd7q                       1/1     Running   0          8m43s
argocd-repo-server-75c657669b-bp866                 1/1     Running   0          8m43s
argocd-server-7bbfdb874-s5h4l                       1/1     Running   0          8m43s
```

## Access Argo CD

### Expose the ArgoCD UI

`kubectl port-forward svc/argocd-server -n argocd 8002:443`

The Argo CD UI will now be available at [https://127.0.0.1:8002](https://127.0.0.1:8002)

### Get admin password

The default username is admin and we need to get the password from a secret stored on the K8s cluster

`kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo`

