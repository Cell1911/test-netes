output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.testnetes.public_ip
}

output "ssh_command" {
  description = "SSH connection command"
  value       = "ssh -i ~/.ssh/${var.key_name}.pem ubuntu@${aws_instance.testnetes.public_ip}"
}

output "kubectl_port_forward" {
  description = "Command to port-forward Kubernetes dashboard"
  value       = "ssh -i ~/.ssh/${var.key_name}.pem -L 8080:localhost:8080 ubuntu@${aws_instance.testnetes.public_ip}"
}