locals {
  # this is the service name inside the k8s cluster
  mongo_host      = local.release
  mongo_port      = 27017
  mongo_database  = var.database_name
  replica_set_key = random_password.replica_set_key.result

  mongo_root_user          = "root"
  mongo_root_user_password = random_password.root_user_password.result
  mongo_app_user           = "appUser"
  mongo_app_user_password  = random_password.app_user_password.result

  # Docs show host1,host2,host3 but we have one DNS
  # service name so we only have 1 hostname
  # The ?replicaSet=rs0 is a per-replicaset identifier
  # It's possible to have 3 replicas (1 primary and 2 replicas)
  # but there will still only be "1" host and replicaSet=rs0 won't change with the number
  # of replicas
  # mongodb://[username:password@]host1[:port1][,...hostN[:portN]][/[defaultauthdb][?options]]

  data_infrastructure = {
    kubernetes_service   = local.mongo_host
    kubernetes_namespace = var.namespace
  }

  data_authentication = {
    username = local.mongo_root_user
    password = local.mongo_root_user_password
    hostname = local.mongo_host
    port     = local.mongo_port
  }

  specs_mongo = {
    version = local.mongo_db_version
  }

  artifact_mongo_authentication = {
    authentication = local.data_authentication
    infrastructure = local.data_infrastructure
    specs = {
      mongo = local.specs_mongo
    }
  }
}

resource "massdriver_artifact" "mongo_authentication" {
  field                = "mongo_authentication"
  provider_resource_id = "${var.namespace}/${local.mongo_host}"
  name                 = "Mongo at ${var.namespace}/${local.mongo_host}"
  artifact             = jsonencode(local.artifact_mongo_authentication)
}
