resource "aws_iam_policy" "demo_project_server_backup_policy" {
    name = "server_backup"
    path = "/"
    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [{
            Effect = "Allow"
            Action = [
                "ec2.CreateSnapshots",
                "ec2.DescribeInstances",
                "ec2:CreateTags",
                
            ]
        }]
    })
}

resource "aws_iam_role" "demo_project_server_backup_role" {
    assume_role_policy = ""
}



resource "aws_lambda_function" "demo_project_server_backup" {
    runtime = "python3.12"
    handler = lambda_function.lambda_handler
    function_name = "server_backup"
    filename = ""
    role = ""
}