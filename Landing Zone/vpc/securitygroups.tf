
resource "aws_security_group" "ec2_linux_sg" {
    description            = "Security group for Linux instances"
    egress                 = [
        {
            cidr_blocks      = [
                "0.0.0.0/0",
                ]
            description      = ""
            from_port        = 0
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            protocol         = "-1"
            security_groups  = []
            self             = false
            to_port          = 0
            },
        ]
  
    ingress                = [
        {
            cidr_blocks      = [
                "0.0.0.0/0",
                ]
            description      = "Access web applications hosted on linux instances"
            from_port        = 80
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            protocol         = "tcp"
            security_groups  = []
            self             = false
            to_port          = 80
            },
        {
            cidr_blocks      = [
                "0.0.0.0/0",
                ]
            description      = "SSH access to linux instances"
            from_port        = 22
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            protocol         = "tcp"
            security_groups  = []
            self             = false
            to_port          = 22
            },
        ]

    tags                   = {
        "Account"         = "VPC"
        "CreatedBy"       = "Terraform"
        "EnvironmentType" = "prod"
        "Name"            = "ec2_linux_sg"
        } 
}

resource "aws_security_group" "ec2_windows_sg" {
    description            = "Security group for Windows instances"
    egress                 = [
        {
            cidr_blocks      = [
                "0.0.0.0/0",
                ]
            description      = ""
            from_port        = 0
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            protocol         = "-1"
            security_groups  = []
            self             = false
            to_port          = 0
            },
        ]

    ingress                = [
        {
            cidr_blocks      = [
                "0.0.0.0/0",
                ]
            description      = "Access web applications hosted on windows instances"
            from_port        = 80
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            protocol         = "tcp"
            security_groups  = []
            self             = false
            to_port          = 80
            },
        {
            cidr_blocks      = [
                "0.0.0.0/0",
                ]
            description      = "RDP access to windows instances"
            from_port        = 3389
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            protocol         = "tcp"
            security_groups  = []
            self             = false
            to_port          = 3389
            },
        ]

    tags                   = {
        "Account"         = "VPC"
        "CreatedBy"       = "Terraform"
        "EnvironmentType" = "prod"
        "Name"            = "ec2_windows_sg"
    }
}

resource "aws_security_group" "lb_linux_sg" {
    description            = "Security group for Linux load balancer"
    egress                 = [
        {
            cidr_blocks      = [
                "0.0.0.0/0",
                ]
            description      = ""
            from_port        = 0
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            protocol         = "-1"
            security_groups  = []
            self             = false
            to_port          = 0
            },
        ]

    ingress                = [
        {
            cidr_blocks      = [
                "0.0.0.0/0",
                ]
            description      = "Allow web traffic to the LB"
            from_port        = 80
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            protocol         = "tcp"
            security_groups  = []
            self             = false
            to_port          = 80
            },
        ]
  
    tags                   = {
        "Account"         = "VPC"
        "CreatedBy"       = "Terraform"
        "EnvironmentType" = "prod"
        "Name"            = "lb_linux_sg"
        }
}

resource "aws_security_group" "lb_windows_sg" {
    description            = "Security group for Windows load balancer"
    egress                 = [
        {
            cidr_blocks      = [
                "0.0.0.0/0",
                ]
            description      = ""
            from_port        = 0
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            protocol         = "-1"
            security_groups  = []
            self             = false
            to_port          = 0
            },
        ]

    ingress                = [
        {
            cidr_blocks      = [
                "0.0.0.0/0",
                ]
            description      = "Allow web traffic to the LB"
            from_port        = 80
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            protocol         = "tcp"
            security_groups  = []
            self             = false
            to_port          = 80
            },
        ]

    tags                   = {
        "Account"         = "VPC"
        "CreatedBy"       = "Terraform"
        "EnvironmentType" = "prod"
        "Name"            = "lb_windows_sg"
        }
}