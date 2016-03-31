JSONAPI.configure do |config|
  config.operations_processor = :jsonapi_authorization
  config.resource_key_type = :uuid
  #config.default_paginator = :paged
end
