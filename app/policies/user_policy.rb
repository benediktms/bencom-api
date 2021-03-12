# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  authorize :user

  def show?
    self?
  end

  def update?
    self?
  end

  def destroy?
    self?
  end

  private

  def self?
    # record represents the object that is being accessed
    record.id == user.id
  end
end
