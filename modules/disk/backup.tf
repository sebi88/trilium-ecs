resource "aws_dlm_lifecycle_policy" "data_volume_backup" {
  description        = "Backup for ${var.name}-data disk"
  execution_role_arn = aws_iam_role.data_volume_backup.arn
  state              = "ENABLED"

  policy_details {
    resource_types = ["VOLUME"]

    target_tags = {
      Name = "${var.name}-data"
    }

    schedule {
      name = "Daily snapshots"

      create_rule {
        interval      = 24
        interval_unit = "HOURS"
        times         = ["23:45"]
      }

      retain_rule {
        count = 7
      }

      tags_to_add = {
        SnapshotCreator = "DLM"
        Name            = "${var.name}-data"
      }
    }
  }

  tags = {
    Name = "DLM ${var.name}-data"
  }

}