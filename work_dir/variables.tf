variable "name" {
  description = "The machine name"
}

variable "machine_type" {
  description = "The machine type to deploy"
  default = "n1-standard-1"
}

variable "zone" {
  description = "The availability zone to use"
  default = "europe-west1-b"
}
