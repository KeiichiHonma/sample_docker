#############################
##### BASIC
#############################
variable "project" {}
variable "env" {} 

variable "project_name" {
  default = "sleepdays"
}

variable "location" {
  default = "asia-northeast1-a"
}


#############################
##### GKE
#############################

variable "machine_type" {
  default = "n1-standard-2"
  # 2vCPU @1node
  # memory 7.5GB @1node 
}

variable "primary_node_count" {
  default = "3"
}

variable "min_node_scale_count" {
  default = "2"
}

variable "max_node_scale_count" {
  default = "3"
}

variable "newrelic_service_account_email" {}


#############################
##### CLOUD SQL
#############################

variable "sql_region" {
  default = "asia-northeast1"
}

variable "network" {
  default = "default"
}

variable "sql_instance_type" {
  # default = "db-n1-standard-1"
  # 1vCPU
  # memory 3.75GB 

  default = "db-f1-micro"
  # 1vCPU
  # memory 614MB
}

#############################
##### Logging export
#############################

variable "logging_storage" {
  default = "MULTI_REGIONAL"
  # default = "REGIONAL"
  # default = "NEARLINE"
  # default = "COLDLINE"

}