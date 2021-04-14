# ARO Automation

This project provides automation corresponding to the ARO Tutorial found at https://docs.microsoft.com/en-us/azure/openshift/tutorial-create-cluster.  Automation is driven via Ansible using [Ansible Galaxy](https://galaxy.ansible.com/).

Ansible contains documentation on working with [Microsoft Azure](https://docs.ansible.com/ansible/2.9/scenario_guides/guide_azure.html) that will be used as a reference for the work here.

# Prerequisites

[Ansible 2.9](https://docs.ansible.com/ansible/2.9/installation_guide/intro_installation.html)
[Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
[Python3](https://www.python.org/downloads/)

# Configuration
This set of Ansible automation makes the assumption that you are using Python3.  To ensure that you have the correct Python and are configured correctly, run the following

`./configure.sh`

The above will also install the Azure modules required to run the playbooks, so it's a good idea to run this.

# Registrations

You will need to login to Azure via the CLI and get your subscription key.  Next, create an environmental variable AZ_SUBSCRIPTION for that key and invoke the following script to setup your resource providers for Azure.

`./register_providers.sh`