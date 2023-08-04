resource "aws_iam_role" "EC2_SSM_Role" {
    description           = "Allows EC2 instances to call AWS services on your behalf."
    
    tags                  = {
        "Account"         = "IAM"
        "CreatedBy"       = "AWS"
        "EnvironmentType" = "prod"
        "Name"            = "EC2_SSM_Role"
    }

    assume_role_policy    = jsonencode(
        {
            Statement = [
                {
                    Action    = "sts:AssumeRole"
                    Effect    = "Allow"
                    Principal = {
                        Service = "ec2.amazonaws.com"
                    }
                },
            ]
            Version   = "2012-10-17"
        }
    )

    managed_policy_arns   = [
        "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
        "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy",
    ]
   
}