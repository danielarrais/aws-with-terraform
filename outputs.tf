output "infra" {
  value = {
    ec2-instances = module.ec2.instances
    efs-id = module.ec2-storage.ec2-efs-multi-az-id
    alb-dns = module.load-balances-auto-scaling.alb-dns
  }
}