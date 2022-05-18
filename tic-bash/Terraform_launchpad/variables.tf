variable "access_key" {
  description = "Access Key"
  type = string
  sensitive = true
}

variable "secret_key" {
  description = "Secret Key"
  type = string
  sensitive = true
}

variable "instance-ami" {
  description = "Ubuntu Ami"
  default = "ami-0851b76e8b1bce90b"
}

variable "instance-type" {
  description = "Instance type"
  default = "t2.micro"
}

variable "instance-key-path" {
  description = "SSH Public Key path"
  default = "./TIC_terraform_key.pem"
}

variable "instance-key-name" {
  description = "The name of the SSH key to associate to the instance. Note that the key must exist already."
  type        = string
  default     = "TIC_terraform_key"
}

# variable "instance-associate-public-ip" {
#   description = "Defines if the EC2 instance has a public IP address."
#   type        = "string"
#   default     = "true"
# }

# variable "user-data-script" {
#   description = "The filepath to the user-data script, that is executed upon spinning up the instance"
#   type        = "string"
#   default     = ""
# }

variable "instance-tag-name" {
  description = "instance-tag-name"
  type        = string
  default     = ""
}

variable "sourceUrl" {
  description = "User-github-link"
  type = string
  default = ""
}

# variable "vpc-cidr-block" {
#   description = "The CIDR block to associate to the VPC"
#   type        = string
#   default     = "10.0.0.0/16"
# }

# variable "subnet-cidr-block" {
#   description = "The CIDR block to associate to the subnet"
#   type        = string
#   default     = "10.0.1.0/24"
# }

# variable "vpc-tag-name" {
#   description = "The Name to apply to the VPC"
#   type        = string
#   default     = "VPC-created-with-terraform"
# }

# variable "ig-tag-name" {
#   description = "The name to apply to the Internet gateway tag"
#   type        = string
#   default     = "aws-ig-created-with-terraform"
# }

# variable "subnet-tag-name" {
#   description = "The Name to apply to the VPN"
#   type        = string
#   default     = "VPN-created-with-terraform"
# }

variable "sg-tag-name" {
  description = "The Name to apply to the security group"
  type        = string
  default     = "TIC_tic-launchpad-sg"
}