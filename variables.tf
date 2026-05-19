variable "region" {
  default = "us-east-1"
}

variable "availability_zone" {
  default = "us-east-1a"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "ssh_allowed_cidr" {
  description = "Your IP address in CIDR notation (e.g. 1.2.3.4/32). Run: curl -s ifconfig.me/ip"
  type        = string
}