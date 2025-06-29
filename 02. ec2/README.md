## Amazon EC2

EC2 means **Elastic Compute Cloud** is one of the most popular services of AWS' offering. This service possibility rent
instances of VMs Linux, Windows or Mac OS with diferents configurations, storing data on virtual drives (EBS), scaling
the services using an auto-scaling group (ASG).

Knowing EC2 is fundamental to undestand how the Cloud works.

### Configurations options

On moment on launch the EC2 instance we have many options for configure VM:

- The operating System (OS): Linux, Windows or macOS
- How much compute power and cores (CPU), random-access memory (RAM)
- How much storage space:
    * Network-attached (EBS and EFS)
    * Hardware (EC2 Instance Store)
- Network card: speed of the card, public IP address
- Firewall rules: security group
- Bootstrap script (run at first launch): EC2 User Data

#### EC2 User Data

It's a script run as root that's possible to bootstrap your instances on first launch. With the EC2 User Data script we
can automate anything you can thin of. For example in below example is maked a script for update my linux, install
docker and configure a nginx conteiner for test the access to port 80:

```bash
#! /bin/bash  
  
# Install Docker  
sudo dnf update -y  
sudo dnf install docker -y  
  
# Auto start Docker when starting the machine  
sudo systemctl start docker  
sudo systemctl enable docker  
  
# Start nginx container  
sudo docker run -it --rm -d -p 80:80 --name web nginxdemos/hello
```

With this script after the instance is launched, we can access the nginx container on port 80.

### Instances types

Name convention:

Sample: m5.2Xlarge

- M: Instance class
- 5: Generation of the hardware
- 2xlarge: size within the instance class

#### Proposes

- General
- Compute Optimized
- Memory Optimized
- Accelerated Computing
- Storage Optimized
- HPC Optimized

### Security Groups

Securities groups are acting as a "firewall" on EC2 instances. They regulate:

- Access to ports
- Authorized IP ranges - IPv4 and IPv6
- Control of inbound network (from the other to the instance)
- Control of outbound network (from the instance to others)

Security groups can be attached to multiples instances.
It's good to maintain one separate security group for SSH access.
All outbound traffic is authorised by default and the inbound is blocked

### Security Roles

We can't use AWS securities keys inside the EC2 instance. The recommendation is: using roles to allow the EC2 access the
necessary resources. For that we need
create [instance profiles](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_switch-role-ec2_instance-profiles.html)
to connect the instances to roles.

We can add a role on the page off instance on "Actions > Security > Modify IAM role".