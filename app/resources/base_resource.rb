class BaseResource < JSONAPI::Resource
  abstract

  def fetchable_fields
    if(context[:user].admin?)
      super - [:password]
    else
      super - [:role, :password]
    end
  end
end
