$redis = Redis.new(
  host: Rails.application.secrets.redis_host,
  port: Rails.application.secrets.redis_port,
  driver: :hiredis
)
