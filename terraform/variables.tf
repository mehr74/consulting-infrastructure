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

variable "tags" {
  type = map(string)
  default = {
    Name = "consulting"
    Environment = "dev"
  }
}

variable "root_url" {
  type = string
  default = "coachcrew.tech."
}

variable "url" {
  type = string
  default = "consulting.coachcrew.tech"
}

variable "region"  {
  type = string
  default = "eu-central-1" 
}