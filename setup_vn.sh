#!/bin/bash

if [[ -z "${LOCATION}" ]]; then
  echo "Environment variable LOCATION is not set.  Please set this to your cluster region."
  exit 1
fi

if [[ -z "${RESOURCEGROUP}" ]]; then
  echo "Environment variable RESOURCEGROUP is not set.  Please set this to your desired resource group."
  exit 1
fi

if [[ -z "${CLUSTER}" ]]; then
  echo "Environment variable CLUSTER is not set.  Please set this to your desired name of your cluster."
  exit 1
fi

AZURE=`which az`

if [[ $? != 0 ]];then
  echo "Azure CLI not found. Please install and re-run this script."
  exit 1
fi

echo "Creating resource group"
$AZURE group create --name $RESOURCEGROUP --location $LOCATION

if [[ $? != 0 ]]; then
  echo "Something went wrong with resource group creation.  Please check output above."
  exit 1
fi

echo "Creating virtual network"
$AZURE network vnet create --resource-group $RESOURCEGROUP --name aro-vnet --address-prefixes 10.0.0.0/22

if [[ $? != 0 ]]; then
  echo "Something went wrong with virtual network creation.  Please check output above."
  exit 2
fi

echo "Adding empty subnet for the master nodes."
$AZURE network vnet subnet create --resource-group $RESOURCEGROUP --vnet-name aro-vnet --name master-subnet \
  --address-prefixes 10.0.0.0/23 --service-endpoints Microsoft.ContainerRegistry

if [[ $? != 0 ]]; then
  echo "Something went wrong with master subnet creation.  Please check output above."
  exit 3
fi

echo "Registering empty subnet for the worker nodes"
$AZURE network vnet subnet create --resource-group $RESOURCEGROUP --vnet-name aro-vnet --name worker-subnet \
  --address-prefixes 10.0.2.0/23  --service-endpoints Microsoft.ContainerRegistry

if [[ $? != 0 ]]; then
  echo "Something went wrong with worker subnet creation.  Please check output above."
  exit 4
fi

echo "Disabling subnet private endpoint policies"
$AZURE network vnet subnet update --name master-subnet --resource-group $RESOURCEGROUP --vnet-name aro-vnet \
  --disable-private-link-service-network-policies true

if [[ $? != 0 ]]; then
  echo "Something went wrong with master subnet policies.  Please check output above."
  exit 5
fi


echo "Virtual network setup completed successfully!"
exit 0