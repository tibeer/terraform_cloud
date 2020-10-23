resource "openstack_compute_instance_v2" "vm_with_fip" {
  name              = var.name
  flavor_name       = var.flavor
  image_name        = var.image
  key_pair          = var.keypair
  availability_zone = var.zone
  count             = var.counter
  security_groups   = var.secgroups

  network {
    name = var.network
  }
}

resource "openstack_networking_floatingip_v2" "fip" {
  pool  = var.pool
  count = var.counter
}

resource "openstack_compute_floatingip_associate_v2" "fip" {
  floating_ip = element(openstack_networking_floatingip_v2.fip.*.address, var.count.index)
  instance_id = element(openstack_compute_instance_v2.vm_with_fip.*.id, count.index)
  count       = var.counter
}
