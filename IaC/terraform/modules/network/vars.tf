variable vpc_cidr_block {
  type        = string
  default     = ""
  description = "CIDR block for the VPC"
}

variable subnet_cidr_block {
  type        = string
  default     = ""
  description = "CIDR block for the subnet"
}
