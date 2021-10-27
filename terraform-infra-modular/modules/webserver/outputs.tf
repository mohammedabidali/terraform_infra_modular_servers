output "output_webserver_ip_address" {
  value = aws_instance.cyber94_calculator_2_mohammed_webserver_tf.*.public_ip
  #value = aws_instance.cyber94_calculator_2_mohammed_webserver_tf.public_ip
}
