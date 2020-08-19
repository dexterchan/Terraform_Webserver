

resource "aws_iam_role" "ecs_terraform_instance_role" {
    name = "ecs_terraform_instance_role"
    assume_role_policy = file("./modules/policies/ec2-trustEntity.json")
    #assume_role_policy = data.template_file.ecs_role_policy.rendered
}

/*
inline policy , avoid it!!!
resource "aws_iam_role_policy" "ecs_terraform_instance_role_policy" {
    name = "ecs_terraform_instance_role_policy"
    policy = file("./modules/policies/ecs-instance-role-policy.json")
    role = aws_iam_role.ecs_terraform_instance_role.id
}*/
resource "aws_iam_role_policy_attachment" "ecs_terraform_ec2_role" {
  role       = aws_iam_role.ecs_terraform_instance_role.id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_role_policy_attachment" "ecs_terraform_ec2_cloudwatch_role" {
  role       = aws_iam_role.ecs_terraform_instance_role.id
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}


resource "aws_iam_instance_profile" "ecs_terraform_profile" {
    name = "ecs_terraform_profile"
    path = "/"
    #roles = [aws_iam_role.ecs_terraform_instance_role.name]
    role = aws_iam_role.ecs_terraform_instance_role.name
}

resource "aws_iam_role" "ecs_terraform_service_role" {
    name = "ecs_terraform_service_role"
    assume_role_policy = file("./modules/policies/ecs-trustEntity.json")
}

resource "aws_iam_role_policy_attachment" "ecs_terraform_service_role_policy" {
    role = aws_iam_role.ecs_terraform_service_role.id
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}

resource "aws_iam_role" "ecs_terraform_taskexecution_role" {
    name = "ecs_terraform_taskexecution_role"
    assume_role_policy = file("./modules/policies/ecs-tasks-trustEntity.json")
}

resource "aws_iam_role_policy_attachment" "ecs_terraform_taskexecution_role_policy" {
    role = aws_iam_role.ecs_terraform_taskexecution_role.id
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role" "ecs_task_app_execution_role" {
    name = "ecs_task_app_execution_role"
    assume_role_policy = file("./modules/policies/ecs-tasks-trustEntity.json")
}

resource "aws_iam_role_policy_attachment" "ecs_task_app_execution_role_s3_policy" {
    role = aws_iam_role.ecs_task_app_execution_role.id
    policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "ecs_task_app_execution_role_dynamodb_policy" {
    role = aws_iam_role.ecs_task_app_execution_role.id
    policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
}

resource "aws_iam_role_policy_attachment" "ecs_task_app_execution_role_xraywrite_policy" {
    role = aws_iam_role.ecs_task_app_execution_role.id
    policy_arn = "arn:aws:iam::aws:policy/AWSXRayDaemonWriteAccess"
}

resource "aws_iam_role_policy_attachment" "ecs_task_app_execution_role_ssm_policy"{
    role = aws_iam_role.ecs_task_app_execution_role.id
    policy_arn = "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess"
}

resource "aws_iam_policy" "ecs_task_app_execution_role_kms_policy" {
  name        = "kms-decrypt-policy"
  description = "Enable decryption policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "kms:Decrypt",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ecs_task_app_execution_role_kms_policy"{
    role = aws_iam_role.ecs_task_app_execution_role.id
    policy_arn = aws_iam_policy.ecs_task_app_execution_role_kms_policy.arn
}

//Below is the inline policy
data "template_file" "ecs_role_policy" {
  template = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": [
          "ecs.amazonaws.com",
          "ec2.amazonaws.com"
        ]
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}
