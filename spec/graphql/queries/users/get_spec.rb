# frozen_string_literal: true

module Queries
  module Users
    RSpec.describe Get do
      subject(:execute) do
        BencomApiSchema.execute(query, variables: variables, context: context)
      end

      let(:user) { create(:user) }
      let(:context) { { current_user: user } }
      let(:unauthorized_user) { create(:user) }

      describe '.resolve' do
        context 'when authorized' do
          let(:variables) { { id: user.id } }

          it 'returns the user' do
            data = execute.dig('data', 'getUser')

            expect(data).to include(
              'email' => user.email, 'firstName' => user.first_name
            )
          end
        end

        context 'when unauthorized' do
          let(:variables) { { id: unauthorized_user.id } }

          it 'fails' do
            data = execute.dig('data', 'showUser')
            error_message = execute['errors'].first['message']

            expect(data).to be_nil
            expect(error_message).to eq('You are not authorized to perform this action')
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
