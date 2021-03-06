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

variable "bootstrap_path" {
  description = "Script to install Docker Engine"
  default = "install_docker.sh"
}

variable "ami" {
  description = "Ubuntu Ami"
  default = "ami-0851b76e8b1bce90b"
}

variable "instance_type" {
  description = "Instance type"
  default = "t2.micro"
}

variable "key_path" {
  description = "SSH Public Key path"
  default = "./TIC_Terraform_Key.pem"
}

variable "key_name" {
  description = "Desired name of Keypair..."
  default = "TIC_Terraform_Key"
}

variable "public_key" {
  default = "TIC_Terraform_Key.pub"
}

variable "private_key" {
  default = "TIC_Terraform_Key.pem"
}
