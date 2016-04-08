module DeviseMapping
  extend ActiveSupport::Concern

  included do
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
    end
  end

  [:get, :post, :put, :patch, :delete].each do |http_method|
    define_method("auth_#{http_method}") do |action_name, params = {}, headers = {}, flash = {}|
      debugger
      auth_params = {
        'access-token' => controller.current_user.last_token,
        'client' => controller.current_user.last_client_id,
        'uid' => controller.current_user.email,
        'user_id' => controller.current_user.id
      }
      params = params.merge(auth_params)
      public_send(http_method, action_name, params, headers, flash)
    end
  end
end
