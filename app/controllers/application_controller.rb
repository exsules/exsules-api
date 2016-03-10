class ApplicationController < ActionController::API
  after_action :add_headers
  include DeviseTokenAuth::Concerns::SetUserByToken

  def serialize_model(model, options = {})
    options[:is_collection] = false
    JSONAPI::Serializer.serialize(model, options)
  end

  def serialize_models(models, options = {})
    options[:is_collection] = true
    JSONAPI::Serializer.serialize(models, options)
  end

  private

  def add_headers
    response.headers['user-id'] = current_user.id if current_user
    response.headers['Content-Type'] = JSONAPI::MIMETYPE
  end

  def unauthorized!
    render json: { errors: [ status: 403, bla: 'bla']  }, status: 403
  end
end
