variable "aws_region"{
description = "Region for VPC"
  default     = "ap-southeast-1"

}
variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  default     = "10.0.0.0/16"
}
variable "public_subnet_cidr" {
  description = "CIDR for public subnets"
  default     = "10.0.1.0/24"
}
variable "private_subnet_cidr" {
  description = "CIDR for private subnets"
  default     = "10.0.2.0/24"
}
variable "ami"{
  description = "Amaxon Linux AMI"
  default     ="ami-0fca02518e0faeb84"
}
variable "key_path"{
  description = "SSH Public Key Path"
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCYOYV/afimVgq/bbxEUGVd1IIA1E4OVE3mjwY+rehU/8usS9L0zEeXOeiF/zwSiAobcnRDTw8lMo6jp2nonCgIymqbcQT2ssVHhauHPQAMnyD5P9E/m5nkiwy6VhIbX3tENhUfSHm5bdDUv2kZtPFRdhqWDQqbffADS7lH/j6kHA3BtsJl5fKaera5kMJCB+2BQ5YNf+dAIbH28XfpRgMwz4OgRLRQALyzZ5ktpMEfCKuPLwN7Ea7tJJY4EuiAcCFmhBv20Tma5oNIzKpI2BPTBEG7crmQ9cj9UfShsWmy6zZUxBilqyy89BlTgCnGYC+E9NYsjfofmGQNFTN3Kw3Z"
}
