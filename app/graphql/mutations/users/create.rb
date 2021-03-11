# frozen_string_literal: true

module Mutations
  module Users
    class Create < Mutations::BaseMutation
      argument :first_name, String, required: true
      argument :last_name, String, required: true
      argument :email, String, required: true
      argument :password, String, required: true

      field :user, Types::UserType, null: true
      field :message, String, null: true
      field :errors, [String], null: true

      def resolve(**args)
        result = ::Users::Create.call(attributes: args)

        {
          user: result.user,
          message: result.message,
          errors: result.errors
        }
      end
    end
  end
end
