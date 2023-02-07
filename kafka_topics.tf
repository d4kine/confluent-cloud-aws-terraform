
resource "confluent_kafka_topic" "test" {
  provider = confluent.kafka
  topic_name    = "test"
  partitions_count = 2
}

resource "confluent_service_account" "app-kafka-user" {
  display_name = "app-kafka-user"
  description  = "Service account to produce and consume from '*' topic of 'dev-cluster' Kafka cluster"
}

resource "confluent_api_key" "app-kafka-user-api-key" {
  display_name = "app-kafka-user-api-key"
  description  = "Kafka API Key that is owned by 'app-kafka-user' service account"
  owner {
    id          = confluent_service_account.app-kafka-user.id
    api_version = confluent_service_account.app-kafka-user.api_version
    kind        = confluent_service_account.app-kafka-user.kind
  }

  managed_resource {
    id          = confluent_kafka_cluster.basic.id
    api_version = confluent_kafka_cluster.basic.api_version
    kind        = confluent_kafka_cluster.basic.kind

    environment {
      id = confluent_environment.dev.id
    }
  }
}

resource "confluent_kafka_acl" "app-kafka-user-write-on-topic" {
  provider = confluent.kafka

  resource_type = "TOPIC"
  resource_name = "*"
  pattern_type  = "LITERAL"
  principal     = "User:${confluent_service_account.app-kafka-user.id}"
  host          = "*"
  operation     = "WRITE"
  permission    = "ALLOW"
}


// Note that in order to consume from a topic, the principal of the consumer ('app-consumer' service account)
// needs to be authorized to perform 'READ' operation on both Topic and Group resources:
// confluent_kafka_acl.app-consumer-read-on-topic, confluent_kafka_acl.app-consumer-read-on-group.
// https://docs.confluent.io/platform/current/kafka/authorization.html#using-acls
resource "confluent_kafka_acl" "app-kafka-user-read-on-topic" {
  provider = confluent.kafka

  resource_type = "TOPIC"
  resource_name = "*"
  pattern_type  = "LITERAL"
  principal     = "User:${confluent_service_account.app-kafka-user.id}"
  host          = "*"
  operation     = "READ"
  permission    = "ALLOW"
}

resource "confluent_kafka_acl" "app-kafka-user-read-on-group" {
  provider = confluent.kafka

  resource_type = "GROUP"
  // The existing values of resource_name, pattern_type attributes are set up to match Confluent CLI's default consumer group ID ("confluent_cli_consumer_<uuid>").
  // https://docs.confluent.io/confluent-cli/current/command-reference/kafka/topic/confluent_kafka_topic_consume.html
  // Update the values of resource_name, pattern_type attributes to match your target consumer group ID.
  // https://docs.confluent.io/platform/current/kafka/authorization.html#prefixed-acls
  resource_name = "confluent_cli_consumer_"
  pattern_type  = "PREFIXED"
  principal     = "User:${confluent_service_account.app-kafka-user.id}"
  host          = "*"
  operation     = "READ"
  permission    = "ALLOW"
}