class BaseResource < JSONAPI::Resource
  include JSONAPI::Authorization::PunditScopedResource
  abstract

  def fetchable_fields
    if(context[:user].admin?)
      super - [:password]
    else
      super - [:role, :password]
    end
  end
end
