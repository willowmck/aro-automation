#!/bin/bash

if [[ -z "${AZ_SUBSCRIPTION}" ]]; then
  echo "Environment variable AZ_SUBSCRIPTION is not set.  Please set this to your Azure subscription id."
  exit 1
fi

AZURE=`which az`

if [[ $? != 0 ]];then
  echo "Azure CLI not found. Please install and re-run this script."
  exit 1
fi

echo "Registering with your Subscription"
$AZURE account set --subscription $AZ_SUBSCRIPTION

if [[ $? != 0 ]]; then
  echo "Something went wrong with your subscription.  Please check output above."
  exit 1
fi

echo "Registering the RedHat OpenShift provider"
$AZURE provider register -n Microsoft.RedHatOpenShift --wait

if [[ $? != 0 ]]; then
  echo "Something went wrong with provider registration.  Please check output above."
  exit 2
fi

echo "Registering the Compute provider"
$AZURE provider register -n Microsoft.Compute --wait

if [[ $? != 0 ]]; then
  echo "Something went wrong with provider registration.  Please check output above."
  exit 3
fi

echo "Registering the Network provider"
$AZURE provider register -n Microsoft.Network --wait

if [[ $? != 0 ]]; then
  echo "Something went wrong with provider registration.  Please check output above."
  exit 4
fi

echo "Registering the Storage provider"
$AZURE provider register -n Microsoft.Storage --wait

if [[ $? != 0 ]]; then
  echo "Something went wrong with provider registration.  Please check output above."
  exit 5
fi

echo "Registering the Authorization provider"
$AZURE provider register -n Microsoft.Authorization --wait

if [[ $? != 0 ]]; then
  echo "Something went wrong with provider registration.  Please check output above."
  exit 6
fi

echo "Registration completed successfully!"
exit 0