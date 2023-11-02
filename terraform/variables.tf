variable "buckets_paths" {
  type = list(object({
    bucket = string
    path = string
  }))
  default = [
    {
      bucket = "consulting-main"
      path = "/"
    },
    {
      bucket = "consulting-blog"
      path = "/blog"
    },
    {
      bucket = "consulting-training"
      path = "/training"
    }
  ]
}