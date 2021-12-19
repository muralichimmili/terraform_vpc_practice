terraform {

  backend "s3" {
  }

}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}