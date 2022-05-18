output "Infra_ip" {
  value = aws_instance.Infra.*.public_ip
}
