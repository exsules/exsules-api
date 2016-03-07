Sidekiq.configure_server do |config|
  config.redis = {
    url: "redis://#{Rails.application.secrets.redis_host}:#{Rails.application.secrets.redis_port}"
  }
end

Sidekiq.configure_client do |config|
  config.redis = {
    url: "redis://#{Rails.application.secrets.redis_host}:#{Rails.application.secrets.redis_port}"
  }
end
