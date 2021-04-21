#GSK Tasks

Terraform : Setup two AWS EC2 ubuntu16.04-xenial-amd64-server instances with Secuirty Group and AWS Elastic Load Balancer.

Ansible : Provision the Packages, docker, nginx, Enable Services, validate infrastrucuture readiness for the application deployment

#Navigate to terraform folder

Install terraform modules, download them

terraform init: Initialize the modules and setup configuration

terraform plan: Description on the action items and To-Do

terraform apply:Perform the action items to provision the servers, instances, applications, security groups, vpc, cidr, ingress/outgress rules

terraform destroy: Delete all - at the end

#Navigate to ansible folder

Check that your ansible connect to ec2 instances ansible -i hosts all -m ping -u ubuntu

App deployment - Run ansible playbook ansible-playbook -i hosts deployment.yml
