resource "aws_ebs_volume" "data_volume" {
  availability_zone = "${data.aws_region.current.name}-${var.zone_letter}"
  size              = 2
  encrypted         = true
  type              = "gp3"
  snapshot_id       = var.data_volume_snapshot_id

  tags = {
    Name = var.name
  }
}