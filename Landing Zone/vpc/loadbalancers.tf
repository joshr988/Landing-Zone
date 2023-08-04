resource "aws_lb" "linux-loadbalancer" {
    load_balancer_type                          = "application"
    security_groups                             = [
        aws_security_group.lb_linux_sg.id
        ]
    
    subnets                                     = [
        aws_subnet.public_subnet[0].id,
        aws_subnet.public_subnet[1].id,
        aws_subnet.public_subnet[2].id,
        ]
    
    subnet_mapping { subnet_id = aws_subnet.public_subnet[0].id}
    subnet_mapping { subnet_id = aws_subnet.public_subnet[1].id}
    subnet_mapping { subnet_id = aws_subnet.public_subnet[2].id}
   
   tags                                        = {
        "Account"         = "VPC"
        "CreatedBy"       = "AWS"
        "EnvironmentType" = "prod"
        "Name"            = "linux-loadbalancer"
        }
    }

resource "aws_lb" "windows-loadbalancer" {
    load_balancer_type                          = "application"
    
    security_groups                             = [
        aws_security_group.lb_windows_sg.id
        ]
    
    subnets                                     = [
        aws_subnet.public_subnet[0].id,
        aws_subnet.public_subnet[1].id,
        aws_subnet.public_subnet[2].id,
        ]
    
    subnet_mapping { subnet_id = aws_subnet.public_subnet[0].id}
    subnet_mapping { subnet_id = aws_subnet.public_subnet[1].id}
    subnet_mapping { subnet_id = aws_subnet.public_subnet[2].id}

    tags                                        = {
        "Account"         = "VPC"
        "CreatedBy"       = "AWS"
        "EnvironmentType" = "prod"
        "Name"            = "windows-loadbalancer"
        }
    }

resource "aws_lb_target_group" "linux-targetgroup" {
    vpc_id            = aws_vpc.project_vpc.id
    target_type                       = "instance"
    port                              = 80
    protocol                          = "HTTP"
    protocol_version                  = "HTTP1"
    slow_start                        = 0
    tags                              = {
        "Account"         = "VPC"
        "CreatedBy"       = "Terraform"
        "EnvironmentType" = "prod"
        "Name"            = "linux-targetgroup"
        }

    health_check {
        enabled             = true
        healthy_threshold   = 5
        interval            = 30
        matcher             = "200"
        path                = "/"
        port                = "traffic-port"
        protocol            = "HTTP"
        timeout             = 5
        unhealthy_threshold = 2
        }

    stickiness {
        cookie_duration = 86400
        enabled         = false
        type            = "lb_cookie"
        }
    }


resource "aws_lb_target_group" "windows-targetgroup" {
    vpc_id            = aws_vpc.project_vpc.id
    target_type                       = "instance"
    port                              = 80
    protocol                          = "HTTP"
    protocol_version                  = "HTTP1"
    slow_start                        = 0
    tags                              = {
        "Account"         = "VPC"
        "CreatedBy"       = "Terraform"
        "EnvironmentType" = "prod"
        "Name"            = "windows-targetgroup"
        }

    health_check {
        enabled             = true
        healthy_threshold   = 5
        interval            = 30
        matcher             = "200"
        path                = "/"
        port                = "traffic-port"
        protocol            = "HTTP"
        timeout             = 5
        unhealthy_threshold = 2
        }

    stickiness {
        cookie_duration = 86400
        enabled         = false
        type            = "lb_cookie"
        }
    }