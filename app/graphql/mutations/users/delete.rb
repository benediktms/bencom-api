# frozen_string_literal: true

module Mutations
  module Users
    class Delete < Mutations::BaseMutation
      argument :user_id, ID, required: true

      field :message, String, null: true
      field :errors, [String], null: true

      def resolve(user_id:)
        user = ::Users::Get.call(id: user_id).user

        authorize! user, to: :destroy? if user

        result = ::Users::Delete.call(user: user)

        {
          message: result.message,
          errors: result.messages
        }
      end
    end
  end
end
