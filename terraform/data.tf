data aws_caller_identity current {}

#data aws_ecr_image lambda_image {
#  depends_on = [
#    null_resource.ecr_image
#  ]
##  repository_name = local.ecr_repository_name
#  image_tag       = local.ecr_image_tag
#}

data aws_iam_policy_document lambda {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    effect = "Allow"
    resources = [ "*" ]
    sid = "CreateCloudWatchLogs"
  }

  statement {
    actions = [
      "codecommit:GitPull",
      "codecommit:GitPush",
      "codecommit:GitBranch",
      "codecommit:ListBranches",
      "codecommit:CreateCommit",
      "codecommit:GetCommit",
      "codecommit:GetCommitHistory",
      "codecommit:GetDifferences",
      "codecommit:GetReferences",
      "codecommit:BatchGetCommits",
      "codecommit:GetTree",
      "codecommit:GetObjectIdentifier",
      "codecommit:GetMergeCommit"
    ]
    effect = "Allow"
    resources = [ "*" ]
    sid = "CodeCommit"
  }
}