resource "aws_s3_bucket" "s3bucket" {
    bucket                      = "703443639063-tfstate"
    force_destroy               = false
    object_lock_enabled         = false

    tags                        = {
        "Account"         = "S3"
        "CreatedBy"       = "Terraform"
        "EnvironmentType" = "prod"
        "Name"            = "703443639063-tfstate"
    }

}

resource "aws_s3_bucket_versioning" "version_my_bucket" {
    bucket = "703443639063-tfstate"

    versioning_configuration {
        status = "Enabled"
    }
}