#!/usr/bin/env bash 

# 1. Add The Rancher and Cert-Manager helm repo (https://ranchermanager.docs.rancher.com/getting-started/installation-and-upgrade/install-upgrade-on-a-kubernetes-cluster)
helm repo add rancher-latest https://releases.rancher.com/server-charts/latest
# 2. Add the Jetstack Helm repository (https://cert-manager.io/docs/installation/helm/)
helm repo add jetstack https://charts.jetstack.io
# 3. Update helm repo
helm repo update
# 4. Install the cert-manager Helm chart
helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.17.2 \
  --set crds.enabled=true

# 4.1 Verify cert-manager is successfully deployed
kubectl get pods --namespace cert-manager

# 5. Install Rancher Latest
helm install rancher rancher-latest/rancher \
  --namespace cattle-system \
  --create-namespace \
  --set hostname=rancher.homelab.blastwave.lab\
  --set bootstrapPassword=admin

# 6. Verify rancher server is successfully deployed
kubectl -n cattle-system rollout status deploy/rancher
kubectl -n cattle-system get deploy rancher

# 7. Expose and Verify Rancher service is deployed
kubectl expose deployment rancher --name=rancher-lb --port=443 --type=LoadBalancer -n cattle-system
kubectl get svc -n cattle-system
