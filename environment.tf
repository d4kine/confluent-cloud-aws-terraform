###
# Setup ConfluentCloud environment with an admin service account
#

resource "confluent_environment" "dev" {
  display_name = "dev"
}

resource "confluent_service_account" "env-manager" {
  display_name = "env-manager-dev"
  description  = "Service account to manage 'DEV' environment"
}

resource "confluent_role_binding" "env-manager-admin" {
  principal   = "User:${confluent_service_account.env-manager.id}"
  role_name   = "EnvironmentAdmin"
  crn_pattern = confluent_environment.dev.resource_name
}


resource "confluent_api_key" "env-manager-api-key" {
  display_name = "env-manager-dev-api-key"
  description  = "API Key that is owned by env-manager-dev service account"
  owner {
    id          = confluent_service_account.env-manager.id
    api_version = confluent_service_account.env-manager.api_version
    kind        = confluent_service_account.env-manager.kind
  }

  depends_on = [
    confluent_role_binding.env-manager-admin
  ]
}
