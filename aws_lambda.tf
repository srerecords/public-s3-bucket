variable "aws_region" {
  default = "eu-central-1"
}

provider "aws" {
  region          = "${var.aws_region}"
}

resource aws_lambda_function public_bucket {
  filename         =  "./script.zip"
  function_name    = "public_bucket_6"
  role             = "${aws_iam_role.iam_for_check_bucket_6.arn}"
  description      = "Searching public buckets"
  handler          = "find_public_s3_bucket.handler"
  runtime          = "python3.8"
  timeout          = 120
  publish          = true
}


resource "aws_iam_role" "iam_for_check_bucket_6" {
  name = "iam_for_check_bucket_6"
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
