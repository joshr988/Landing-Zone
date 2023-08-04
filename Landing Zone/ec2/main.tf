resource "aws_instance" "Linux-Bastion" {
  ami           = "ami-06ca3ca175f37dd66"
  instance_type = "t2.micro"

  tags = {
    "Account"         = "EC2"
    "CreatedBy"       = "AWS"
    "EnvironmentType" = "prod"
    "Name"            = "Linux-Bastion"
  }
}

resource "aws_instance" "Windows-Bastion" {
  ami           = "ami-04132f301c3e4f138"
  instance_type = "t2.micro"

  tags = {
    "Account"         = "EC2"
    "CreatedBy"       = "AWS"
    "EnvironmentType" = "prod"
    "Name"            = "Windows-Bastion"
  }
}

resource "aws_instance" "team-a-linux-server-1" {
  ami           = "ami-0952aa75e3e5fe3ee"
  instance_type = "c5.large"

  tags = {
    "Account"         = "EC2"
    "CreatedBy"       = "mgn.amazonaws.com"
    "EnvironmentType" = "prod"
    "Name"            = "team-a-linux-server-1"
  }
}

resource "aws_instance" "team-a-linux-server-3" {
  ami = "ami-07e2ad04b1c38613d"
  tags = {
    "Account"         = "EC2"
    "CreatedBy"       = "mgn.amazonaws.com"
    "EnvironmentType" = "prod"
    "Name"            = "team-a-linux-server-3"
  }
}
 