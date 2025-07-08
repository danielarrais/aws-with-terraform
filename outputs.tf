output "infra" {
  value = {
    ec2-instances = module.ec2.instances
    efs_id = module.ec2-storage.ec2-efs-multi-az-id
  }
}