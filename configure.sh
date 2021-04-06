#!/bin/bash

ANSIBLE=`which ansible`

if [[ $? != 0 ]]; then
  echo "ansible not found. Please install Ansible locally and re-run this script."
  exit 1
fi

$ANSIBLE --version

PYTHON_VERSION=`$ANSIBLE --version | grep "python version" | cut -d' ' -f6 | cut -d'.' -f1`

if [[ $PYTHON_VERSION != "3" ]];then 
  echo "Python version found $PYTHON_VERSION is less than 3."
  echo "See https://docs.ansible.com/ansible/latest/reference_appendices/python_3_support.html for recommendations on how to install properly."
  exit 1
fi

AZURE=`which az`

if [[ $? != 0 ]];then
  echo "Azure CLI not found. Please install and re-run this script."
  exit 1
fi

$AZURE --version

PIP='pip'
$PIP install 'ansible[azure]'
if [[ $? != 0 ]];then
  echo "Something went wrong install the Azure module!"
  exit 1
fi

echo "Everything looks good!"
exit 0