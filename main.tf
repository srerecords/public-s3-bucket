variable "aws_region" {
  default = "eu-central-1"
}

provider "aws" {
  region          = "${var.aws_region}"
}


resource "aws_lambda_function" "public_bucket" {
  filename         =  "./script.zip"
  function_name    = "public_bucket"
  role             = "${aws_iam_role.role_check_bucket.arn}"
  description      = "Searching public buckets"
  handler          = "find_public_s3_bucket.handler"
  runtime          = "python3.8"
  timeout          = 120
  publish          = true
}


resource "aws_iam_role" "role_check_bucket" {
  name = "role_check_bucket"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "policy_check_bucket" {
  name = "policy_check_bucket"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:*"
            ],
            "Resource": "arn:aws:s3:::*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:*"
            ],
            "Resource": "arn:aws:s3:::*"
        }
    ]
}
EOF
}


resource "aws_iam_role_policy_attachment" "attach_check_bucket" {
  role       = "${aws_iam_role.role_check_bucket.name}"
  policy_arn = "${aws_iam_policy.policy_check_bucket.arn}"
}

