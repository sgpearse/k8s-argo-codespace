# k8s-argo-codespace
This repository provides a preconfigured environment that starts a Kubernetes cluster on Docker when launched in Visual Studio (VS) Code desktop. If VS Code is not installed on your machine, please see [Download Visual Studio Code](https://code.visualstudio.com/download) 

```note
This walkthrough requires Docker to be installed on your machine and the Docker engine must be running for everything to start appropriately. 
```

## Getting Started
Fork this repository in to your own GitHub account. Once the repository has been forked select the button labeled `<> Code` in the upper right of the webpages body. This opens a dropdown containing 2 tabs. The default tab that opens is the Local tab and contains information on how to Clone the repository. Select the Codespaces tab and use the `Create codespace on main` button to launch a new tab in your browser containing an Interactive Development Environment (IDE) with the repository code.  

In the upper left there are three horizontally stacked lines, often referred to as a hamburger button, click this to open a dropdown menu. Near the bottom is a link to `Open in VS Code desktop`. Select this and it will prompt to confirm that VS Code should be opened. When VS Code launches a script will setup the environment and automatically run `minikube start` to launch a Kubernetes (K8s) cluster. As long as minikube starts without any issues it can now be used to install apps and get familiar with how Argo CD deploys and manages applications. 

## Install Argo CD

The first steps we will take are to create a namespace in K8s named argocd and then install Argo CD into that namespace. This can be accomplished by pasting the following commands in to the terminal window in VS Code.

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

With that password you can now login to the Argo CD with the admin username. 

## Install flask-helm chart

This repository contains a Helm chart that runs a very basic Flask application. 