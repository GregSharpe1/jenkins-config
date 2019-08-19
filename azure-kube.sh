#!/bin/bash

# Make sure to exit on error
set -e

RG_NAME="jenkins-kubernetes-demo"
RG_LOCATION="uksouth"
AKS_NAME="jenkins-master-demo"

## Run the Az command as a container
az ()
{
	docker run -it --rm -v "${HOME}/.azure:/root/.azure" -v "${HOME}/.kube:/root/.kube" -v "${HOME}/.ssh/azure-container:/root/.ssh" --log-driver none jess/azure-cli "$@"
}

create ()
{
  # Create resource group
  echo "LOG: Creating resource group..."
  az group create --name "${RG_NAME}" --location "${RG_LOCATION}"

  # Create the AKS cluster
  echo "LOG: Creating AKS Cluster ${AKS_NAME}..."
  az aks create --resource-group "${RG_NAME}" --name "${AKS_NAME}" --node-count 1 --generate-ssh-keys

  # Make sure aks cli is installed
  echo "LOG: Installing aks cli..."
  az aks install-cli

  # Grab the kubectl config
  echo "LOG: Grabbing kube config..."
  az aks get-credentials --resource-group "${RG_NAME}" --name "${AKS_NAME}"
}

delete ()
{
  echo "LOG: Deleting resource group ${RG_NAME}..."
  az group delete --name "${RG_NAME}"
}

usage()
{
  echo ""
  echo "./azure-kube.sh create | delete"
  echo ""
}

while [ "${1}" != "" ]; do
  case "${1}" in 
    create | c )
      create
      shift;;
    delete | d )
      delete
      shift;;
    * )
      usage
      exit 1
  esac
  shift
done
