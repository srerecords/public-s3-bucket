variable script_path {
  default = ""
}

# don't put boto3 inside: you have boto3 in Lambda python env
# you have a limit of 5MB package!
variable pip_dependencies {
  default = [] 
}

variable temp_package_folder {
  default = "python_lambda_package"
}
#script_sha1
#variable package_filename {
#  default = "package.zip"
#}
