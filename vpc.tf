# 1 Create a vpc
resource "aws_vpc" "lab-vpc" {
  cidr_block       = "25.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  instance_tenancy = "default"

  tags = {
    Name = "lab-vpc"
    Environment = "devops"
  }
}

# 2 Create IGW
resource "aws_internet_gateway" "lab-igw" {
  vpc_id = aws_vpc.lab-vpc.id

  tags = {
    Name = "lab-igw"
    Environment = "devops"
  }
}

# 3 Create a publlic Route Table
resource "aws_route_table" "lab_Public_RT" {
  vpc_id = aws_vpc.lab-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lab-igw.id
  }

#  route {
 #   ipv6_cidr_block        = "::/0"
 #   egress_only_gateway_id = aws_egress_only_internet_gateway.example.id
 # }

  tags = {
    Name = "lab_Public_RT"
    Environment = "devops"
  }
}

# 4 Create Public/ Private subnets in eu-west-2a
resource "aws_subnet" "lab_Public_Subnet_2a" {
  vpc_id     = aws_vpc.lab-vpc.id
  cidr_block = "25.0.0.0/24"
  availability_zone = "eu-west-2a"

  tags = {
    Name = "lab_Public_Subnet"
    Environment = "devops"
  }
}

# 5 Associate the subnet with the route table
resource "aws_route_table_association" "Public_RT 1" {
  subnet_id      = aws_subnet.lab_Public_Subnet_2a.id
  route_table_id = aws_route_table.lab_Public_RT.id
}

# 6 Create a Security Group
resource "aws_security_group" "allow_tls" {
  name        = "Lab-SG"
  description = "Allow SSH and RDP from a single IP address & https from anywhere"
  vpc_id      = aws_vpc.lab-vpc.id

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["198.167.100.20/32"]
    #ipv6_cidr_blocks = ["::/0"]
  }

 ingress {
    from_port        = 3389
    to_port          = 3389
    protocol         = "tcp"
    cidr_blocks      = ["198.167.100.20/32"]
    #ipv6_cidr_blocks = ["::/0"]
  
  }
   ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0./0"]
    #ipv6_cidr_blocks = ["::/0"]
  }

   egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0./0"]
    #ipv6_cidr_blocks = ["::/0"]
   }

    tags = {
    Name = "Lab-SG"
    Environment = "devops"
  }
}

# 7 Create a network interface with IP in the subnet that was created i step 4
resource "aws_network_interface" "lab-public-eni-2a id" {
  subnet_id       = aws_subnet.lab_Public_Subnet_2a.id
  private_ips     = ["25.0.0.4"]
  security_groups = [Lab-SG.id]

 # attachment {
  #  instance     = aws_instance.test.id
   # device_index = 1
  #}
}

# 8 Assign an elastic IP to the network interface created in step 7
resource "aws_eip" "lab-eip1" {
  domain                    = "vpc"
  network_interface         = aws_network_interface.lab-public-eni-2a.id
  associate_with_private_ip = "25.0.0.4"

   depends_on = [aws_internet_gateway.lab-igw]
}

# 9 Launch an EC2 instance
resource "aws_instance" "Lab-instance" {
  ami           = "ami-005e54dee72cc1d00" # us-west-2
  instance_type = "t2.micro"
    key_name = "Web server" 

  network_interface {
    network_interface_id = aws_network_interface.lab-public-eni-2a.id
    device_index         = 0
  }

  root_block_device {
    volume_size = 12
  }
  
    tags = {
      Name = "Web server"
      Environment = "devops"
    }
}