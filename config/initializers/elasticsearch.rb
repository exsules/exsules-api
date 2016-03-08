require 'faraday'
require 'typhoeus/adapters/faraday'

es_url = "#{Rails.application.secrets.es_host}:#{Rails.application.secrets.es_port}" || 'localhost:9200'
if es_url
  Searchkick.client = Elasticsearch::Client.new({
    url: es_url
  })
end

