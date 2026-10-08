output "public_ips" {
  description = "Public IP of each server"
  value       = { for name, s in aws_instance.server : name => s.public_ip }
}

output "private_ips" {
  description = "Private IP of each server"
  value       = { for name, s in aws_instance.server : name => s.private_ip }
}

output "grafana_url" {
  description = "Grafana address"
  value       = "http://${aws_instance.server["monitoring"].public_ip}:3000"
}

output "prometheus_url" {
  description = "Prometheus address"
  value       = "http://${aws_instance.server["monitoring"].public_ip}:9090"
}

output "ssh_commands" {
  description = "SSH command for each server"
  value       = { for name, s in aws_instance.server : name => "ssh -i ~/.ssh/dataops-key ec2-user@${s.public_ip}" }
}
