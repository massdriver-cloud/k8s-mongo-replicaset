locals {
  chart_version = "11.0.6"
  # The chart doesn't have a "mongo version" field, this is a local used in
  # the artifact so we can expose the mongo version being used
  # It looks like we could override the docker image for various
  # parts of mongo. The arbiter, the mongod instances, etc..
  # I assume 3.latest would work but didn't go down the path of swapping out
  # various components to support another major version
  mongo_db_version = "4.4.13"
  release          = var.md_metadata.name_prefix
}

resource "random_password" "root_user_password" {
  length  = 10
  special = false
}

resource "random_password" "replica_set_key" {
  length  = 10
  special = false
}

resource "random_password" "app_user_password" {
  length  = 10
  special = false
}

resource "helm_release" "mongodb" {
  name             = local.release
  chart            = "mongodb"
  repository       = "https://charts.bitnami.com/bitnami"
  version          = local.chart_version
  namespace        = var.namespace
  create_namespace = true

  values = [
    "${file("${path.module}/values.yaml")}",
    yamlencode(local.helm_values)
  ]
}
