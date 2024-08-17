resource "aws_iam_group" "group" {
    name = "DemoGroup"
}

resource "aws_iam_user" "user" {
    name = "DemoUser"
}