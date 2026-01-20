
provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "frontend" {
  ami                         = var.frontend_ami
  instance_type               = var.instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.frontend.id]
  subnet_id                   = aws_subnet.public.id
  tags = {
    Name = "FrontendServer"
  }
}

resource "aws_instance" "backend" {
  ami                         = var.backend_ami
  instance_type               = var.instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.backend.id]
  subnet_id                   = aws_subnet.private.id
  tags = {
    Name = "BackendServer"
  }
}

resource "aws_db_instance" "database" {
  allocated_storage    = 20
  engine               = "mysql"
  instance_class       = "db.t3.micro"
  name                 = var.db_name
  username             = var.db_user
  password             = var.db_password
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
}

resource "aws_sns_topic" "notifications" {
  name = "bank-notifications"
}

resource "aws_cloudwatch_log_group" "devops_logs" {
  name              = "/aws/devops/logs"
  retention_in_days = 30
}

resource "aws_lambda_function" "integration_function" {
  filename         = "integration_function.zip"
  function_name    = "integration_function"
  role             = aws_iam_role.lambda_exec.arn
  handler          = "index.handler"
  runtime          = "nodejs14.x"
  source_code_hash = filebase64sha256("integration_function.zip")
}

resource "aws_cloudwatch_metric_alarm" "cpuload_high" {
  alarm_name          = "HighCPUUtilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "80"
  alarm_actions       = [aws_sns_topic.notifications.arn]
}

resource "aws_api_gateway_rest_api" "api" {
  name        = "Bank Self-Service API"
  description = "API for bank self-service portal"
}

resource "aws_iam_role" "lambda_exec" {
  name = "lambda_exec_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_security_group" "frontend" {
  name        = "frontend_sg"
  description = "Allow inbound traffic for frontend"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "backend" {
  name        = "backend_sg"
  description = "Allow inbound traffic for backend"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_subnet" "public" {
  vpc_id            = var.vpc_id
  cidr_block        = var.public_subnet_cidr
  availability_zone = var.public_subnet_az
}

resource "aws_subnet" "private" {
  vpc_id            = var.vpc_id
  cidr_block        = var.private_subnet_cidr
  availability_zone = var.private_subnet_az
}
