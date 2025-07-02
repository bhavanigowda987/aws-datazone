data "aws_caller_identity" "current" {}

resource "aws_iam_role" "execution" {
  name = "datazone-execution-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = [
          "datazone.amazonaws.com",
          "lakeformation.amazonaws.com",
          "glue.amazonaws.com"
        ]
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy_attachment" "attach_policy" {
  name       = "datazone-full-access"
  roles      = [aws_iam_role.execution.name]
  policy_arn = "arn:aws:iam::aws:policy/AWSLakeFormationDataAdmin"
}

output "execution_role_arn" {
  value = aws_iam_role.execution.arn
}