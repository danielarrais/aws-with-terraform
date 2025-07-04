## EC2 - Security Groups

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