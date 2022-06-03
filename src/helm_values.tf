locals {
  helm_values = {
    commonLabels = var.md_metadata.default_tags
    # instance configuration
    # we set the requests and limits the same for predictible scheduling,
    # easier debugging, and "guranteed class" of workloads
    resources = {
      requests = {
        cpu    = var.instance_configuration.cpu_limit
        memory = "${var.instance_configuration.memory_limit_gib}Gi"
      }
      limits = {
        cpu    = var.instance_configuration.cpu_limit
        memory = "${var.instance_configuration.memory_limit_gib}Gi"
      }
    }
    persistance = {
      size = "${var.instance_configuration.disk_size_gb}Gi"
    }
    # replica configuration
    # we add a 1 here because to the chart this
    # is the total number of instances in the replica set
    # and that includes the primary instance
    replicaCount = var.replica_configuration.number_of_replicas + 1
    # TODO: we might not let the user set this
    service = {
      nameOverride = local.mongo_host
    }
    # authentication
    auth = {
      usernames = [local.mongo_app_user]
      passwords = [local.mongo_app_user_password]
      databases = [local.mongo_database]
      # root user credentials
      rootUser     = local.mongo_root_user
      rootPassword = local.mongo_root_user_password
      # to make changes to the chart, the key needs to be the same
      # we we need to generate it and pass it in
      replicaSetKey = local.replica_set_key
    }
  }
}
