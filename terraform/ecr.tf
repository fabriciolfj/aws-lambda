#resource aws_ecr_repository repo {
#  name = local.ecr_repository_name
#}

#resource null_resource ecr_image {
#  triggers = {
#    python_file = md5(file("${path.module}/lambdas/git_client/index.py"))
#    docker_file = md5(file("${path.module}/lambdas/git_client/Dockerfile"))
#  }


#  provisioner "local-exec" {
#    command = <<EOF
#           aws ecr get-login-password --region ${var.region} | docker login --username AWS --password-stdin ${local.account_id}.dkr.ecr.${var.region}.amazonaws.com
#           cd ${path.module}/lambdas/git_client
#           docker build -t ${aws_ecr_repository.repo.repository_url}:${local.ecr_image_tag} .
#           docker push ${aws_ecr_repository.repo.repository_url}:${local.ecr_image_tag}
#       EOF
#  }
#}