resource "openstack_compute_instance_v2" "test" {
  name              = "beermann-terraform-cloud-test"
  flavor_name       = "1C-1GB-10GB"
  image_name        = "Debian 10"
  key_pair          = "default"
  availability_zone = "south-2"
  count             = var.counter

  security_groups = ["ssh"]

  network {
    name = "net-to-external-common-sandbox"
  }
}

resource "openstack_networking_floatingip_v2" "fip" {
  pool  = "external"
  count = var.counter
}

resource "openstack_compute_floatingip_associate_v2" "fip" {
  floating_ip = element(openstack_networking_floatingip_v2.fip.*.address, var.counter)
  instance_id = element(openstack_compute_instance_v2.test.*.id, var.counter)
  count       = var.counter
}
