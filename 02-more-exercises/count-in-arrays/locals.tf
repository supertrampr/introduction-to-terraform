locals {
  file_path = var.create_file ? [
    for file in local_file.this : "Il path è ${file.filename}"
  ] : []
}