resource "aws_vpc" "api-server" {
  cidr_block = "172.16.0.0/16"

  tags = var.tags
}

resource "aws_subnet" "api-server" {
  vpc_id            = aws_vpc.api-server.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = var.availability_zone

  tags = var.tags
}

resource "aws_internet_gateway" "api-server" {
  vpc_id = aws_vpc.api-server.id

  tags = var.tags
}

resource "aws_route_table" "api-server" {
  vpc_id = aws_vpc.api-server.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.api-server.id
  }
  tags = var.tags
}

resource "aws_route_table_association" "api-server" {
  subnet_id      = aws_subnet.api-server.id
  route_table_id = aws_route_table.api-server.id
}
