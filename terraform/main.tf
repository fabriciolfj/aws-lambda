resource aws_lambda_function git {
  depends_on = [
    null_resource.ecr_image
  ]
  function_name = "${local.prefix}-lambda"
  role = aws_iam_role.lambda.arn
  timeout = 300
  image_uri = "${aws_ecr_repository.repo.repository_url}@${data.aws_ecr_image.lambda_image.id}"
  package_type = "Image"
}
