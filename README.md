# terraform_static_website_s3

To serve your static website at http://shilpas3.sctp-sandbox.com/, you’ll need to:

- Create an S3 bucket named shilpas3.sctp-sandbox.com
- Enable static website hosting on that bucket
- Upload your website files (index.html, etc.)
- Create a Route 53 record pointing shilpas3.sctp-sandbox.com to the S3 website endpoint

To find IAM user
aws iam get-user --query "User.UserName" --output text
