
resource "aws_security_group" "allow_docdb" {
  name        = "roboshopallows internal traffic"
  description = "Allow private traffics"
  vpc_id =   data.terraform_remote_state.vpc.outputs.VPC_ID

  ingress {
    description = "docdb  from private network "
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_sagar"
  }
}

resource "aws_instance" "example_instance" {
  ami             = "ami-xxxxxxxxxxxxxxxxx"  # Replace with your desired AMI ID
  instance_type   = "t2.micro"
  key_name        = "your-key-pair-name"     # Replace with your key pair name
  vpc_security_group_ids = [aws_security_group.sagar.id]

  tags = {
    Name = "example-instance"
  }
}
