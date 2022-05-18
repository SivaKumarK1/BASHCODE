output "instance_ip_addr_manager" {
  value = aws_instance.Manager.*.public_ip
}
output "instance_ip_addr_worker" {
  value = aws_instance.Worker_01.*.public_ip
}
output "instance_ip_addr3_postgres" {
  value = aws_instance.Postgres_instance.*.public_ip
}