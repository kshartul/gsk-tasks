output "instance_id1"{
  value = ["${aws_instance.gsk-one.*.public_ip}"]
  
}

output "instance_id2"{
value = ["${aws_instance.gsk-two.*.public_ip}"]
}

output "elb_dns_name"{
  value = "${aws_elb.example.dns_name}"
}
