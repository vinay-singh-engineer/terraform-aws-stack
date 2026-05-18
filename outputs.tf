output "public_ip" {
  value = aws_instance.web.public_ip
}

output "app_url" {
  value = "http://${aws_instance.web.public_ip}"
}