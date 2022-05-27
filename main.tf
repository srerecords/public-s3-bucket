variable "aws_region" {
  default = "eu-central-1"
}

provider "aws" {
  region          = "${var.aws_region}"
}

resource aws_lambda_function public_bucket {
  filename         =  "./script.zip"
  function_name    = "public_bucket_7"
  role             = "${aws_iam_role.iam_for_check_bucket_7.arn}"
  description      = "Searching public buckets"
  handler          = "find_public_s3_bucket.handler"
  runtime          = "python3.8"
  timeout          = 120
  publish          = true
}



resource "aws_iam_role" "iam_for_check_bucket_7" {
  name = "iam_for_check_bucket_7"
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

#Created Policy for IAM Role
resource "aws_iam_policy" "policy_check_bucket_7" {
  name = "policy_check_bucket_7"

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



#resource "aws_iam_role_policy_attachment" "attach_check_bucket_7" {
#  role       = "${aws_iam_role.role.name}"
#  policy_arn = "${aws_iam_policy.policy.arn}"
#}
