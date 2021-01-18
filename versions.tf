terraform {
  backend "http" {
    address        = "https://gitlab.com/api/v4/projects/1234/terraform/state/my_state" 
    lock_address   = "https://gitlab.com/api/v4/projects/1234/terraform/state/my_state/lock"
    unlock_address = "https://gitlab.com/api/v4/projects/1234/terraform/state/my_state/lock"
    username       = "tux"
    password       = "123123019-asdklnvklj-1230ß-asdalk"
    lock_method    = "POST"
    unlock_method  = "DELETE"
    retry_wait_min = 5
  }
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
    }
  }
  required_version = ">= 0.13"
}
