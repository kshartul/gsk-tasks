variable "region"{
  description = "AWS region"
  default     = "us-east-1"
}

variable "shared_cred_file"{
 default = "~/.aws/credentials"
}


variable "key_name"{
  description = "Key name for SSHing into EC2"
  default     = "deployer-key"
}

variable "ssh_key"{
  description = "Path to the public key to be used for ssh access to the VM."
  default = "~/.ssh/id_rsa.pub"
 }