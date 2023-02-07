#  ENVIRONMENT

output "environment_id" {
  description = "ID of created Environment"
  value       = confluent_environment.dev.id
}

output "environment_name" {
  description = "Name of created Environment"
  value       = confluent_environment.dev.display_name
}

output "env_service_account_id" {
  description = "ID of created Service Account"
  value       = confluent_service_account.env-manager.id
}

output "env_service_account_name" {
  description = "Name of created Service Account"
  value       = confluent_service_account.env-manager.display_name
}

output "env_admin_role_binding_id" {
  description = "Id of the env-admin role bindings"
  value       = confluent_role_binding.env-manager-admin.id
}

output "env_api_key_id" {
  description = "Id of the API Key created for service account"
  value       = confluent_api_key.env-manager-api-key.id
}

output "env_api_key_secret" {
  description = "The secret of the API Key"
  value       = confluent_api_key.env-manager-api-key.secret
  sensitive   = true
}

# CLUSTER

output "kafka_cluster_rest_endpoint" {
  value       = confluent_kafka_cluster.basic.rest_endpoint
}

output "app_service_account_id" {
  description = "ID of created Service Account"
  value       = confluent_service_account.app-manager.id
}

output "app_service_account_name" {
  description = "Name of created Service Account"
  value       = confluent_service_account.app-manager.display_name
}

output "app_api_key_id" {
  description = "Id of the API Key created for service account"
  value       = confluent_api_key.app-manager-kafka-api-key.id
}

output "app_api_key_secret" {
  description = "The secret of the API Key"
  value       = confluent_api_key.app-manager-kafka-api-key.secret
  sensitive   = true
}

# TOPIC

output "app_kafka_user_service_account_id" {
  description = "ID of created Service Account"
  value       = confluent_service_account.app-kafka-user.id
}

output "app_kafka_user_service_account_name" {
  description = "Name of created Service Account"
  value       = confluent_service_account.app-kafka-user.display_name
}

output "app_kafka_user_api_key_id" {
  description = "Id of the API Key created for service account"
  value       = confluent_api_key.app-kafka-user-api-key.id
}

output "app_kafka_user_api_key_secret" {
  description = "The secret of the API Key"
  value       = confluent_api_key.app-kafka-user-api-key.secret
  sensitive   = true
}