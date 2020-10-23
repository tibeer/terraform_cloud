module "vms_debian" {
  source = "${path.module}./vm_with_fip"
  
  counter   = 3
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
  source = "${path.module}./vm_with_fip"
  
  counter   = 3
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
  source = "${path.module}./vm_with_fip"
  
  counter   = 3
  name      = "Beermann"
  flavor    = "1C-1GB-10GB"
  image     = "openSUSE Leap 15.2"
  keypair   = "default"
  zone      = "south-2"
  secgroups = ["ssh"]
  network   = "net-to-external-common-sandbox"
  pool      = "external"
}

