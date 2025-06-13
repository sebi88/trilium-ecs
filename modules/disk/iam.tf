data "aws_iam_policy_document" "data_volume_backup_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["dlm.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "data_volume_backup" {
  name               = "${var.name}-dlm-lifecycle-role"
  assume_role_policy = data.aws_iam_policy_document.data_volume_backup_assume_role.json
}

data "aws_iam_policy_document" "data_volume_backup" {
  statement {
    effect = "Allow"

    actions = [
      "ec2:CreateSnapshot",
      "ec2:CreateSnapshots",
      "ec2:DeleteSnapshot",
      "ec2:DescribeInstances",
      "ec2:DescribeVolumes",
      "ec2:DescribeSnapshots",
    ]

    resources = ["*"]
  }

  statement {
    effect    = "Allow"
    actions   = ["ec2:CreateTags"]
    resources = ["arn:aws:ec2:*::snapshot/*"]
  }
}

resource "aws_iam_role_policy" "data_volume_backup" {
  name   = "${var.name}-dlm-lifecycle-policy"
  role   = aws_iam_role.data_volume_backup.id
  policy = data.aws_iam_policy_document.data_volume_backup.json
}

