aws ecr get-login-password --region us-east-2 | docker login --username fabriciolfj --password-stdin 763114715754.dkr.ecr.us-east-2.amazonaws.com
#ou usar o resultado do get login
#docker login -u AWS -p <password> <aws_account_id>.dkr.ecr.<region>.amazonaws.com

aws ecr create-repository --repository-name hello-world --image-scanning-configuration scanOnPush=true --image-tag-mutability MUTABLE

docker tag  hello-world:latest 763114715754.dkr.ecr.us-east-2.amazonaws.com/hello-world:latest
docker push 763114715754.dkr.ecr.us-east-2.amazonaws.com/hello-world:latest