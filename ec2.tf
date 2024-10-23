resource "aws_instance" "public-server" {
  count           = length(var.azs)
  ami             = var.ami
  instance_type   = var.aws_instance_type
  subnet_id       = aws_subnet.public_subnet[count.index].id
  availability_zone = var.azs[count.index]
  security_groups = ["${aws_security_group.ssh.id}"]
  key_name        = var.kp
  root_block_device {
    volume_size = "20"
    volume_type = "gp3"
    delete_on_termination = true
  }
  tags = {
    Name = "AWS Public Server ${count.index + 1}"
  }
}

resource "aws_instance" "private-server" {
  count           = length(var.azs)
  ami             = var.ami
  instance_type   = var.aws_instance_type
  subnet_id       = aws_subnet.private_subnet[count.index].id
  security_groups = ["${aws_security_group.ssh.id}"]
  key_name        = var.kp
  root_block_device {
    volume_size = "20"
    volume_type = "gp3"
    delete_on_termination = true
  }
  tags = {
    Name = "AWS Private Server ${count.index + 1}"
  }
}

