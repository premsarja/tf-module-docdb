data "terraform_remote_state" "vpc" {
    backend = "s3"
    config ={
      
      bucket = "prems"
      key    = "vpc/${var.ENV}/terraform.tfstate"
      region = "us-east-1"
    }
}

# fetches the secret informatiuon from secret

data "aws_secretsmanager_secret" "secret" {
  name = "robot/secrets"  
}

# fetches the info from the above secret

data "aws_secretsmanager_secret_version" "secret_version" {
  secret_id = data.aws_secretsmanager_secret.secret.id
}

output "example" {
  value = jsondecode(data.aws_secretsmanager_secret_version.secret_version.secret_string)["DOCDB_USERNAME"]
}






