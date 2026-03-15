variable "project_id" {
  description = "ID проєкту в Google Cloud"
  type        = string
}

variable "region" {
  description = "Регіон для ресурсів"
  type        = string
  default     = "europe-west3"
}

variable "student_name" {
  description = "Прізвище та ім'я студента латиницею"
  type        = string
}

variable "var_num" {
  description = "Номер варіанту"
  type        = string
}

variable "subnet_a_cidr" {
  type = string
}

variable "subnet_b_cidr" {
  type = string
}

variable "web_port" {
  type = string
}

variable "server_name" {
  type = string
}

variable "doc_root" {
  type = string
}