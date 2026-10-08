data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

resource "aws_key_pair" "main" {
  key_name   = "${var.project}-key"
  public_key = file(pathexpand(var.ssh_public_key_path))
}

locals {
  servers = {
    monitoring = {
      name = "monitoring-server"
      type = var.monitoring_instance_type
      host = 10
      disk = 20
    }
    worker1 = {
      name = "worker-1"
      type = var.worker_instance_type
      host = 11
      disk = 10
    }
    worker2 = {
      name = "worker-2"
      type = var.worker_instance_type
      host = 12
      disk = 10
    }
  }
}

resource "aws_instance" "server" {
  for_each = local.servers

  ami                         = data.aws_ami.al2023.id
  instance_type               = each.value.type
  subnet_id                   = aws_subnet.public.id
  private_ip                  = cidrhost(var.subnet_cidr, each.value.host)
  vpc_security_group_ids      = [aws_security_group.servers.id]
  key_name                    = aws_key_pair.main.key_name
  associate_public_ip_address = true

  root_block_device {
    volume_size = each.value.disk
    volume_type = "gp3"
  }

  tags = {
    Name = "${var.project}-${each.value.name}"
  }

  lifecycle {
    ignore_changes = [ami]
  }
}
