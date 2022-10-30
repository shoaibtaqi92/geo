
resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Generate a Private Key and encode it as PEM.
resource "aws_key_pair" "key_pair" {
  key_name   = "key"
  public_key = tls_private_key.key.public_key_openssh

  provisioner "local-exec" {
    command = "echo '${tls_private_key.key.private_key_pem}' > ./key.pem"
  }
}



# Create a EC2 Instance
resource "aws_instance" "prod-ec2" {
  instance_type          = var.instance_type
  ami                    = var.ami
  key_name               = aws_key_pair.key_pair.id
  vpc_security_group_ids = var.security_groups
  subnet_id              = var.subnet_id

  tags = {
    Name = "TF Generated EC2"
  }

  user_data = file("${path.root}/ec2/userdata.tpl")

  root_block_device {
    volume_size = 10
  }
}