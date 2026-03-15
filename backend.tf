terraform {
  backend "gcs" {
    bucket = "tf-state-lab3-lopushynskyi-roman-11"
    prefix = "env/dev/var-11"
  }
}