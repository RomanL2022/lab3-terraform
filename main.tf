# 1. Створення VPC
resource "google_compute_network" "vpc" {
  name                    = "vpc-${var.student_name}-${var.var_num}"
  auto_create_subnetworks = false
}

# 2. Створення підмереж
resource "google_compute_subnetwork" "subnet_a" {
  name          = "subnet-a-${var.var_num}"
  ip_cidr_range = var.subnet_a_cidr
  region        = var.region
  network       = google_compute_network.vpc.id
}

resource "google_compute_subnetwork" "subnet_b" {
  name          = "subnet-b-${var.var_num}"
  ip_cidr_range = var.subnet_b_cidr
  region        = var.region
  network       = google_compute_network.vpc.id
}

# 3. Налаштування Firewall (Security Group)
resource "google_compute_firewall" "allow_web_ssh" {
  name    = "fw-allow-web-ssh-${var.var_num}"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22", var.web_port]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["web-server"]
}

# 4. Створення віртуальної машини (VM)
resource "google_compute_instance" "web_server" {
  name         = "vm-${var.student_name}-${var.var_num}"
  machine_type = "e2-micro"
  zone         = "${var.region}-a"
  tags         = ["web-server", "terraform", "lab3"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2404-lts-amd64"
    }
  }

  network_interface {
    network    = google_compute_network.vpc.name
    subnetwork = google_compute_subnetwork.subnet_a.name
    access_config {} # Надає зовнішню IP-адресу
  }

  # Передача скрипта ініціалізації з підстановкою змінних
  metadata = {
    startup-script = templatefile("${path.module}/bootstrap.sh", {
      web_port    = var.web_port
      server_name = var.server_name
      doc_root    = var.doc_root
    })
  }

  labels = {
    student = var.student_name
    variant = var.var_num
  }
}