#!/usr/bin/env bash

# 1. Download the script
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3

# 2. Add execute permission
chmod 700 get_helm.sh

# 3. Execute the helm install script
./get_helm.sh
