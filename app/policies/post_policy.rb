class PostPolicy < ApplicationPolicy
  def update?
    return true if user.admin?
    return true if user.id == record.from_user_id
  end

  def destroy?
    return true if user.admin?
    return true if user.id == record.user.id
    return true if user.id == record.from_user_id
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
