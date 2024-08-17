resource "aws_iam_group" "group" {
    name = "DemoGroup1"
}

resource "aws_iam_user" "user" {
    name = "DemoUser12"
}
terraform {
    backend "s3" {
        bucket = "mybucket-krish-new"
        key    = "terraform.tfstate"
        region = "us-east-1"
    }
}