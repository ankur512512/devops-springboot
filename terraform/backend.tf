terraform {
  backend "gcs" {
    bucket = "my-unique-bucket"
    prefix = "terraform/state"
  }
}