module V1
  class UserResource < BaseResource
    attributes :first_name,
               :last_name,
               :username,
               :location,
               :sex,
               :birthday,
               :role,
               :password,
               :email,
               :slug

    has_many :posts
    has_many :albums, as: :owner

    def fetchable_fields
      if(context[:user].id == @model.id || context[:user].admin?)
        super
      else
        super - [:email]
      end
    end

    def self.find_by_key(key, options = {})
      context = options[:context]
      begin
        record = records(options).friendly.find(key)
      rescue ActiveRecord::RecordNotFound
        raise JSONAPI::Exceptions::RecordNotFound.new(key)
      end
      self.new(record, context)
    end
  end
end
