variable "buckets_paths" {
  type = list(object({
    bucket = string
    path = string
  }))
}

variable "tags" {
  type = map(string)
}

variable "root_url" {
  type = string
}

variable "url" {
  type = string
}

variable "region" {
  type = string 
}