output "map_public_ip_on_launch" {
  value       = aws_subnet.project_subnet.map_public_ip_on_launch
  description = "Indicates whether instances launched in the subnet should be assigned a public IP address"
}

output "public_dns_hostname" {
  value       = aws_instance.app_server.public_dns
  description = "The public DNS of the EC2 instance"

}