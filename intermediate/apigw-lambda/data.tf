data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/hello.py"
  output_path = "${path.module}/lambda_function.zip"
}

data "local_file" "lambda_zip_hash" {
  filename = "${path.module}/lambda_function.zip"
  depends_on = [data.archive_file.lambda_zip]
}