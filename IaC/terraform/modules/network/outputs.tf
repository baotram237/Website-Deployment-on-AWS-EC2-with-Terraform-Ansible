output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.lab_vpc.id
}

output "subnet_id" {
  description = "Subnet ID where the EC2 instance is launched"
  value       = aws_subnet.lab_subnet.id
}

output "security_group_ids" {
  description = "Security Group ID for the Linux lab"
  value       = aws_security_group.linux_lab_sg.id
}