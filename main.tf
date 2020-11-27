module "vms_debian" {
  source = "./vm_with_fip"
  
  counter   = 1
  name      = "Beermann"
  flavor    = "1C-1GB-10GB"
  image     = "Debian 10"
  keypair   = "default"
  zone      = "south-2"
  secgroups = ["ssh"]
  network   = "net-to-external-common-sandbox"
  pool      = "external"
}

module "vms_centos" {
  source = "./vm_with_fip"
  
  counter   = 0
  name      = "Beermann"
  flavor    = "1C-1GB-10GB"
  image     = "CentOS 8"
  keypair   = "default"
  zone      = "south-2"
  secgroups = ["ssh"]
  network   = "net-to-external-common-sandbox"
  pool      = "external"
}

module "vms_opensuse" {
  source = "./vm_with_fip"
  
  counter   = 0
  name      = "Beermann"
  flavor    = "1C-1GB-10GB"
  image     = "openSUSE Leap 15.2"
  keypair   = "default"
  zone      = "south-2"
  secgroups = ["ssh"]
  network   = "net-to-external-common-sandbox"
  pool      = "external"
}

