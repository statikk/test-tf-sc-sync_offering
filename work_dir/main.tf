resource "google_compute_instance" "my-vm" {
  name = "${var.name}"
  machine_type = "${var.machine_type}"
  zone = "${var.zone}"
  boot_disk {
    initialize_params {
      image = "ubuntu-1804-bionic-v20180613"
    }
  }

  network_interface {
    network = "default"
  }

  labels = {
    tier = "front"
    stage = "production"
  }
}

output "instance_id" {
  value = "${google_compute_instance.my-vm.instance_id}"
}
