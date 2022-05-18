#!/bin/bash

# terraform changes to instances
terraform init

terraform validate

terraform plan -var-file="var.tfvars"

terraform apply -var-file="var.tfvars" --auto-approve

terraform output | grep -Po '(\d+[.]){3}\d+' >> ips

#change master ip in hosts file
# rm temp.txt
# sed -i "s/$(awk 'FNR == 2' inventory/hosts > temp.txt && awk '{print $1}' temp.txt)/$(awk "FNR == 2" ips)/g" inventory/hosts
# rm temp.txt
# #change worker ip in hosts file
# sed -i "s/$(awk 'FNR == 4' inventory/hosts > temp.txt && awk '{print $1}' temp.txt)/$(awk "FNR == 3" ips)/g" inventory/hosts
# rm temp.txt
# #change postgres ip in hosts file
# sed -i "s/$(awk 'FNR == 6' inventory/hosts > temp.txt && awk '{print $1}' temp.txt)/$(awk "FNR == 1" ips)/g" inventory/hosts


# sleep 1m
# #Running ansible
# export ANSIBLE_HOST_KEY_CHECKING=False

# ansible-playbook -i inventory/hosts playbook.yml

# rm ips temp.txt
