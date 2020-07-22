
terraform {
  backend "remote" {
    organization = "dextest"

    workspaces {
      name = "aws_ecs_marketdataserver2"
    }
  }
}