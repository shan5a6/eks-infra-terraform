variable "region" {
    default = "us-west-2"
}
variable "customer" {
    default = "dvs"
}
variable "ec2_ssh_key" {
    default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC/i0vmvSWNyeZCMTMzTDFhoFM0XKEPXGLeTKr37Jb5Xp03nMDUNwVGhsUdXL2TdK4ek7/v69ImOgVZKe/ucpdWNT+2KoBH7pLhTg8A6OuN2b+9ZqQVxb2JfdclgRiGwg/r94G2+WXXnRWr5/l2x9C82OrgGwcOUNXGNcStm3WG9N0Y3sTJUwPr3ibANrWFCiuWdYyqT981N+/nWHCMReNnddvS+VxlMZ6A3DuzHWZw7qmB6PCeXchoiSsBQ8aSpXKF+zr32hRuaViYLL7kku8kZJGp+LwcgtBwg3o2gf8WptFP31BLNG9k5gnzc8A2wmt3G3SCO/40jG3B4EOqKZov SHAAN-MCDAIB1"
}
variable "env" {
    default = "dev"
}
variable "vpc_cidr" {
    default = "10.10.0.0/16"
}
variable "public_subnets" {
    type    = list
    default = ["10.10.10.0/24","10.10.15.0/24"]
}

variable "private_subnets" {
    type    = list
    default = ["10.10.20.0/24","10.10.25.0/24"]    
}

variable "availability_zones" {
    type    = list
    default = ["us-west-2a","us-west-2b"]    
}

variable "keypair" {
    default = "dvs-key"
}

variable "cluster_name" {
    default = "dvs-eks"
}

variable "public_nodes_capacity" {
    default = "ON_DEMAND"
}
variable "public_nodes_type" {
    default = "t3.micro"
}
variable "public_nodes_min" {
    default = 1
}

variable "public_nodes_max" {
    default = 2
}

variable "public_nodes_des" {
    default = 1
}

variable "public_nodes_labels" {
    default = {
        env = "public"
    }
}

variable "private_nodes_capacity" {
    default = "ON_DEMAND"
}

variable "private_nodes_type" {
    default = "t3.micro"
}
variable "private_nodes_min" {
    default = 1
}

variable "private_nodes_max" {
    default = 2
}

variable "private_nodes_des" {
    default = 1
}

variable "private_nodes_labels" {
    default = {
        env = "private"
    }
}

variable "max_no_of_pods" {
  default = 40
}
