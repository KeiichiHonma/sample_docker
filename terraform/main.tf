provider "google" {
  #credentials = file("../.gcp_service_accountkeys/terraform/${var.env}/terraform-service-account.json")
  credentials = "${file("../.gcp_service_accountkeys/terraform/${var.env}/terraform-service-account.json")}"
  project = "${var.project}"
  region  = "${var.location}"

}

terraform {
  backend "gcs" {
    bucket = "two2-sleepdays-terraform-state"
    prefix = "terraform/state"
  }
}

resource "google_container_cluster" "primary" {
  name     = "${var.project_name}-${var.env}-cluster"
  location = "${var.location}"

  remove_default_node_pool = true
  initial_node_count       = 1

  network = "${var.network}"

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }
}

resource "google_container_node_pool" "default_nodes" {
  name       = "${var.project_name}-${var.env}-primary-nodes"
  location   = "${var.location}"
  cluster    = "${google_container_cluster.primary.name}"
  node_count = "${var.primary_node_count}"

  management {
    auto_repair = true
  }

  autoscaling {
    min_node_count = "${var.min_node_scale_count}"
    max_node_count = "${var.max_node_scale_count}"
  }

  node_config {
    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/trace.append",
    ]

    machine_type = "${var.machine_type}"
  }
}

resource "google_project_iam_binding" "new-relic" {
  count = "${var.env == "production" ? 1 : 0}"
  role = "roles/viewer"

  members = [
    "serviceAccount:${var.newrelic_service_account_email}",
  ]
}


resource "google_sql_database_instance" "master" {
  name             = "${var.project_name}-${var.env}"
  project          = "${var.project}"
  database_version = "MYSQL_5_7"
  region           = "${var.sql_region}"


  settings {
    tier = "${var.sql_instance_type}"
    backup_configuration {
      enabled = true
    }
    location_preference {
      zone = "${var.location}"
    }
  }
}

resource "google_sql_user" "user_2" {
  instance = "${google_sql_database_instance.master.name}"
  name     = "root"
  host     = "%"
  # password = "" コンソールで設定
}

resource "google_sql_user" "user_1" {
  instance = "${google_sql_database_instance.master.name}"
  name     = "${var.project_name}_user"
  host     = "%"
  # password = "" コンソールで設定
}

resource "google_logging_project_sink" "storage-sink" {
  name   = "${var.project}-logging-sync-storage"
  destination = "storage.googleapis.com/${google_storage_bucket.log-bucket.name}"
  filter = <<EOF
resource.labels.project_id="${var.project}"
EOF
  # unique_writer_identity = true
}
resource "google_storage_bucket" "log-bucket" {
  name          = "${var.project}-logging-bucket"
  location      = "asia"
  storage_class = "${var.logging_storage}"
}


resource "google_logging_project_sink" "bigquery-sink" {
  name   = "${var.project}-logging-sync-bigquery"
  destination = "bigquery.googleapis.com/projects/${var.project}/datasets/${google_bigquery_dataset.log-dataset.dataset_id}"
  filter = <<EOF
resource.labels.project_id="${var.project}"
EOF
  # unique_writer_identity = true
}

resource "google_bigquery_dataset" "log-dataset" {
  dataset_id                  = "logging_sync"
  description                 = "プロジェクト全データのログシンク"
  location                    = "asia-northeast1"
  # default_table_expiration_ms = 604800000 # 7日  

  labels = {
    env = "${var.env}",
    project = "${var.project_name}"
  }
}

resource "google_project_iam_binding" "log-writer" {
  count = "${length(var.logging_writer_roles)}"
  role   = "${element(var.logging_writer_roles, count.index)}"
  members = [
    "${google_logging_project_sink.storage-sink.writer_identity}",
  ]
}

variable "logging_writer_roles" {
  default = [
    "roles/storage.objectCreator",
    "roles/bigquery.dataEditor"
  ]
}

resource "google_logging_project_exclusion" "log_exclusion_healthcheck" {
  name = "log_exclusion_healthcheck"
  description = "Google Load Balancerとkubernetesのヘルスチェックログ（200 正常）の除外"
  filter = <<EOF
resource.type="k8s_container"
resource.labels.project_id="${var.project}"
resource.labels.cluster_name="${google_container_cluster.primary.name}"
resource.labels.namespace_name="default"
resource.labels.container_name="nginx"
textPayload: ("GET / HTTP/1.1\" 200" AND ("GoogleHC/1.0" OR "kube-probe"))
EOF
}

resource "google_logging_project_exclusion" "log_exclusion_assets_file_format" {
  name = "log_exclusion_nginx_assets_file_format"
  description = "画像/動画/css/jsの拡張子のレスポンスログの除外"
  filter = <<EOF
resource.type="k8s_container"
resource.labels.project_id="${var.project}"
resource.labels.cluster_name="${google_container_cluster.primary.name}"
resource.labels.namespace_name="default"
resource.labels.container_name="nginx"
textPayload: ("/assets/" OR "/images/" OR "/fonts/") AND (".jpg" OR ".jpeg" OR ".gif" OR ".png" OR ".svg" OR ".css" OR ".js" OR ".ico" OR ".mp4" OR ".ttf")
EOF
}

