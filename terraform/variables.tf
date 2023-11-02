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

variable "instance_type" {
  type = string
  default = "t2.nano"
}

variable "region"  {
  type = string
  default = "eu-central-1" 
}

variable "public_key" {
  type = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCt/+JcQz8a8UwAYaWUqGIHMWtHOkLKuzbCIy3aQwDMwxRMpEfUXThoiqOnszx8ntWEVEYpgQXJzoi2ltkL5odO1nzWxxLGUeTb3dNa8eaABvhKrrXvB7yZ/W9K2ZQ/tS5JA62zxQg+a1aFw5eT8GtiRm3Fjivo5K5PKOHQsYyYQwsu0E17K/u000+Gef9l1ZKaf/LWujISx8mpXEABFKr1IJRxTI0PeQidLHJSwoiKZ81tCfcRBi1yEJWssfgmdeZZlZvqeKKtd1Z4CXV8ez7BYFCsD3qzutUHUi2cQPTTQPJ084DN/6yPhIOuBevfXHbWxVexb6AorY/0ndPvomVIz9Oc/1B1UY1VvrtQdHwldQ3Wj4BfeHudrrsYdvDa6IgEgVYZM0ciZOGakk2/MXWUpysNtDy89TlNuIEPuZGblJ/LLIxRlF+v89is3/F16btQMz1FYwQePvpEJiMY68ZCqRf8o93D38iP0zRU8OEbfvR3fAAe3UdDXULjyFWOKMEX/yVlKwaXf+XJ6c+z/UKu8+4NtZJdU4nMmqLNc+YFsykNaPU9Grl/1lAIgP6mWZuZxqve0Ht+CqOtxnka8uwmK0DPxBJX9V+Mtj7ATgJtXnopPKvFa6ldpWmbOVU/KjiCQgNyJ6V7Z2kcQtyIBIbChU3ktts0gyquEZlFu1iJqQ== mehrshadlotfi@Mehrshads-MBP.fritz.box"
}