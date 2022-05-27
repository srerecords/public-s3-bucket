output package_path {
  value = data.null_data_source.packaging_changes.outputs["package_path"]
}

output package_sha {
  value = data.archive_file.package.output_base64sha256
}

output handler_file_name {
  value = split(".", basename(var.script_path))[0]
}
