# frozen_string_literal: true

require 'rails_helper'

module Queries
  module Users
    RSpec.describe Get do
      subject(:execute) do
        BencomApiSchema.execute(query, variables: variables, context: context)
      end

      let(:user) { create(:user) }
      let(:context) { { current_user: user } }

      describe '.resolve' do
        context 'authorized' do
          let(:variables) { { id: user.id } }

          it 'returns the user' do
            data = execute.dig('data', 'getUser')

            expect(data).to include(
              'email' => user.email, 'firstName' => user.first_name
            )
          end
        end
      end

      private

      def query
        <<~GRAPHQL
          query($id: ID!) {
            getUser(id: $id) {
              email
              firstName
            }
          }
        GRAPHQL
      end
    end
  end
end
