terraform {
  backend "remote" {
    hostname = "terraform.com:8443"
    organization = "my-organization-0"
    token = "123"

    workspaces {
      name = "my-workspace-0"
    }
  }
}


// Configure the Google Cloud provider
provider "google" {
 credentials = "${file("flask-app-876d96137760.json")}"
 project     = "flask-app-244915"
 region      = "europe-west2"
}

// Terraform plugin for creating random ids
resource "random_id" "instance_id" {
 byte_length = 8
}

// A single Google Cloud Engine instance
resource "change01_google_compute_instance" "default" {
 name         = "flask-vm-${random_id.instance_id.hex}"
 machine_type = "f1-micro"
 zone         = "us-west1-b"

 boot_disk {
   initialize_params {
     image = "debian-cloud/debian-9"
   }
 }

// Make sure flask is installed on all new instances for later steps
 metadata_startup_script = "sudo apt-get update; sudo apt-get install -yq build-essential python-pip rsync; pip install flask"

 network_interface {
   network = "default"

   access_config {
     // Include this section to give the VM an external ip address
   }
 }
}
