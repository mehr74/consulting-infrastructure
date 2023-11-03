data "aws_ami" "amzn-linux-2023-ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

resource "aws_key_pair" "api-server" {
  key_name   = "admin-key"
  public_key = var.public_key
}

resource "aws_security_group" "ingress-all" {
  name        = "allow-ingress-all"
  description = "Allow all ingress traffic"

  vpc_id = aws_vpc.api-server.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
 }
}

resource "aws_instance" "api-server" {
  ami           = data.aws_ami.amzn-linux-2023-ami.id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.api-server.id
  associate_public_ip_address = true
  security_groups = [ aws_security_group.ingress-all.id ]

  key_name = aws_key_pair.api-server.key_name

  tags = var.tags
}
