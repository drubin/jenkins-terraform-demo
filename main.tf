## Will read local vars or ENV variables 
provider "aws" {
	region     = "eu-west-1"
	profile    = "jenkins-demo"
}


resource "aws_s3_bucket" "bucket" {
    bucket = "david-test-demo"
    acl = "public-read"
    policy = <<EOF
{
  "Version":"2012-10-17",
  "Statement":[{
	"Sid":"PublicReadGetObject",
        "Effect":"Allow",
	  "Principal": "*",
      "Action":["s3:GetObject"],
      "Resource":["arn:aws:s3:::david-test-demo/*"
      ]
    }
  ]
}
EOF

    website {
        index_document = "index.html"
        error_document = "error.html"
    }
}

resource "aws_s3_bucket_object" "object" {
    bucket = "${aws_s3_bucket.bucket.id}"
    key = "index.html"
    source = "index.html"
    content_type = "text/html"
    etag = "${md5(file("index.html"))}"
}
