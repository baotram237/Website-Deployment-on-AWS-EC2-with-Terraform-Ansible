#!/bin/bash
set -e

# Step 1: Get Public IP from Terraform
IP=$(cd terraform && terraform output -raw ec2_public_ip)

# Step 2: Run Ansible 
ansible-playbook \
  -i "$IP," \
  -u ubuntu \
  --private-key ~/.ssh/linux_lab_key \
  ansible/site.yml

echo "Deployment complete! Visit: http://$IP"
