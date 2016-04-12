class LikePolicy < ApplicationPolicy
  def create?
    return true
  end
  def update?
    user.admin? || user.id == record.from_user_id
  end

  def destroy?
    user.admin? || user.id == record.from_user_id
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.all
      end
    end
  end
end
