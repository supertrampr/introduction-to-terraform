output "location_of_file" {
  description = "This output will show file location."
  value       = length(local.file_path) > 0 ? local.file_path : ["No files to show."]
}