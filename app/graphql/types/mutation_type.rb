# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::Users::Create, description: 'Creates a user'
    field :update_user, mutation: Mutations::Users::Update, description: 'Updates a user'
    field :delete_user, mutation: Mutations::Users::Delete, description: 'Deletes a user'
    field :login_user, mutation: Mutations::Users::Login, description: 'Login a user'
  end
end
