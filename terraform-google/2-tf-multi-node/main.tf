### Include provider

// Add firewall
resource "google_compute_firewall" "default" {
  name    = "test-firewall"
  network = "default"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "443", "8080", "30000-32767"]
  }

  source_tags = ["cluster"]
}

// Add 3 Compute Engine instance
resource "google_compute_instance" "default" {
  count = 3
  name         = "instance-${count.index +1}"
  machine_type = "e2-medium"
  zone         = "asia-southeast1-b"

  tags = ["cluster"]

  boot_disk {
    initialize_params {
      image = "ubuntu-2004-lts"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  metadata = {
    ssh-keys = "trb:${file("id_rsa.pub")}"
  }

  metadata_startup_script = "${file("script.sh")}"

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}
