class UserPolicy < ApplicationPolicy
  def index?
    return true
  end

  def show?
    return true if user.id == record.id
    return true
  end

  def update?
    true if user.admin? || user == record
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
