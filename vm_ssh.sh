#!/bin/bash
cd env/region/project/instance/infra/vm
terragrunt output -raw tls_private_key > ~/.ssh/id_azure_vm
chmod 600 ~/.ssh/id_azure_vm
vm_ip=`terragrunt output -raw public_ip_address`
echo IP $vm_ip
echo ssh -i ~/.ssh/id_azure_vm azureuser@${vm_ip}
ssh -ti ~/.ssh/id_azure_vm azureuser@${vm_ip}
cd -
