data "archive_file" "zip" {
  type        = "zip"
  source_file = "py.py"
  output_path = "py.zip"
}