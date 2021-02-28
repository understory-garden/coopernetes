resource "aws_iam_user" "dns01-solver" {
  name = "${local.cluster_name}-dns01-solver"
}

resource "aws_iam_access_key" "dns01-solver" {
  user = aws_iam_user.dns01-solver.name
}

resource "aws_iam_user_policy" "dns01-solver" {
  name = "${local.cluster_name}-dns01-solver"
  user = aws_iam_user.dns01-solver.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "route53:GetChange",
            "Resource": "arn:aws:route53:::change/*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "route53:ChangeResourceRecordSets",
                "route53:ListResourceRecordSets"
            ],
            "Resource": "arn:aws:route53:::hostedzone/*"
        },
        {
            "Effect": "Allow",
            "Action": "route53:ListHostedZonesByName",
            "Resource": "*"
        }
    ]
}
EOF
}

