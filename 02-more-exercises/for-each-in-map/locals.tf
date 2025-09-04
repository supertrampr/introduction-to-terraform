locals {
  file_path = { for k, v in local_file.this : k => "Il path del file è ${v.filename}" }
}