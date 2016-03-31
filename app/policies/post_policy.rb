class PostPolicy < ApplicationPolicy
  def destroy?
    p record.user.id
    user.admin? || user.id == record.from_user_id
  end
  class Scope < Scope
    def resolve
      scope
    end
  end
end
