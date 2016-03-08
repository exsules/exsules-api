class ApplicationController < ActionController::API
  after_action :add_headers
  include DeviseTokenAuth::Concerns::SetUserByToken
  include JSONAPI::ActsAsResourceController

  private

  def add_headers
    response.headers['user-id'] = current_user.id if current_user
  end

  def handle_exceptions(e)
    if JSONAPI.configuration.exception_class_whitelist.any? { |k| e.class.ancestors.include?(k)  }
      raise e
    else
      super
    end
  end

  def unauthorized!
    render json: { errors: [ status: 403, bla: 'bla']  }, status: 403
  end

  def context
    { user: current_user }
  end

end
