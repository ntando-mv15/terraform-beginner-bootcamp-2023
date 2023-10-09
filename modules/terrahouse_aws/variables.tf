variable "user_uuid" {
  description = "User UUID"
  type        = string
  validation {
    condition     = can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", var.user_uuid))
    error_message = "The user_uuid value is not a valid UUID."
  }
}


variable "bucket_name" {
  description = "AWS S3 bucket name"
  type        = string

  validation {
    condition     = (
    length(var.bucket_name) > 3 &&  length(var.bucket_name) <= 63 &&
    can(regex("^[a-z0-9][a-z0-9]*[a-z0-9]$", var.bucket_name)))
    error_message = "Invalid bucket name. It must be between 3 and 63 characters and can only contain lowercase letters, numbers, hyphens, and periods. It must start and end with a lowercase letter or number."
  }
}

variable "index_html_filepath" {
  description = "Path to the index.html file"
  type        = string

  validation {
    condition     = fileexists(var.index_html_filepath)
    error_message = "The provided index.html path does not exist or is not a valid file."
  }
}


variable "error_html_filepath" {
  description = "Path to the error.html file"
  type        = string

  validation {
    condition     = fileexists(var.error_html_filepath)
    error_message = "The provided error.html path does not exist or is not a valid file."
  }
}