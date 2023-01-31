resource aws_iam_role lambda {
  name = "${local.prefix}-lambda-role"
  assume_role_policy = <<EOF
{
   "Version": "2012-10-17",
   "Statement": [
       {
           "Action": "sts:AssumeRole",
           "Principal": {
               "Service": "lambda.amazonaws.com"
           },
           "Effect": "Allow"
       }
   ]
}
 EOF
}



resource aws_iam_policy lambda {
  name = "${local.prefix}-lambda-policy"
  path = "/"
  policy = data.aws_iam_policy_document.lambda.json
}