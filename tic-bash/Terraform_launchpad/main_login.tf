provider "aws" {
  region     = "ap-south-1"
  access_key = var.access_key
  secret_key = var.secret_key
}
resource "aws_instance" "Infra" {
  ami                         = var.instance-ami
  instance_type               = var.instance-type
 
  # iam_instance_profile        = var.iam-role-name != "" ? var.iam-role-name : ""
  key_name                    = "${var.instance-key-name != "" ? var.instance-key-name : ""}"
  # associate_public_ip_address = var.instance-associate-public-ip
  # user_data                   = file(var.user-data-script)
  # user_data                   = var.user-data-script != "" ? file(var.user-data-script) : ""
  vpc_security_group_ids      = [aws_security_group.sg.id]
  # subnet_id                   = aws_subnet.subnet.id

  # provisioner "file" {
  #   # copying the scripts to server
  #   connection {
  #     type        = "ssh"
  #     user        = "ubuntu"
  #     private_key = "${file("${var.instance-key-path}")}"
  #     host        = "${self.public_dns}"
  #   }
  #   source = "../*"
  #   destination = "./devops-scripts"
  # }
  provisioner "remote-exec" {

   connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = "${file("${var.instance-key-path}")}"
      host        = "${self.public_dns}"
    }
    inline = [
      "git clone ${var.sourceUrl}"
    ]
  }

  tags = {
    Name = var.instance-tag-name
  }
}


# resource "aws_vpc" "vpc" {
#   cidr_block           = var.vpc-cidr-block
#   enable_dns_hostnames = true

#   tags = {
#     Name = var.vpc-tag-name
#   }
# }

# resource "aws_internet_gateway" "ig" {
#   vpc_id = aws_vpc.vpc.id

#   tags = {
#     Name = var.ig-tag-name
#   }
# }

# resource "aws_subnet" "subnet" {
#   vpc_id     = aws_vpc.vpc.id
#   cidr_block = var.subnet-cidr-block

#   tags = {
#     Name = var.subnet-tag-name
#   }
# }

# resource "aws_route_table" "rt" {
#   vpc_id = aws_vpc.vpc.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.ig.id
#   }
# }

# resource "aws_route_table_association" "rta" {
#   subnet_id      = aws_subnet.subnet.id
#   route_table_id = aws_route_table.rt.id
# }

resource "aws_security_group" "sg" {
  name   = var.sg-tag-name
  # vpc_id = aws_vpc.vpc.id

  ingress {
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "22"
    to_port     = "22"
  }

  ingress {
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "80"
    to_port     = "80"
  }

  ingress {
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "443"
    to_port     = "443"
  }

  ingress {
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "8080"
    to_port     = "8080"
  }

  egress {
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "0"
    to_port     = "0"
  }

  tags = {
    Name = var.sg-tag-name
  }
}

resource "null_resource" "file" {
  provisioner "local-exec" {
    command = <<EOT
    echo "Infra,${aws_instance.Infra.public_ip}" > body.csv
    EOT
  }
  
}