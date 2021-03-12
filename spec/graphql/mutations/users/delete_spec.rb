# frozen_string_literal: true

module Mutations
  module Users
    RSpec.describe Delete, type: :request do
      subject(:execute) do
        post graphql_path,
             params: { query: query_string, variables: variables }
      end

      let(:user) { create(:user) }
      let(:unauthorized_user) { create(:user) }

      describe '.resolve' do
        let(:variables) { { userId: user.id } }

        context 'with valid params' do
          it 'deletes the user' do
            execute

            json = JSON.parse(response.body)
            data = json.dig('data', 'deleteUser')

            expect(data['message']).to eq 'You have successfully deleted your account'
            expect(data['errors']).to be_nil
          end
        end

        # TODO: find a way to test this properly
        # context 'when it fails' do
        #   let(:error_message) { ['Your account could not be deleted at this time'] }
        #   let(:result) { Interactor::Context.new(errors: error_message) }

        #   before do
        #     allow(::Users::Delete).to receive(:call)
        #       .with(user: user)
        #       .and_return(result)

        #     allow(result).to receive(:success?).and_return(false)
        #     allow(result).to receive(:failure?).and_return(true)
        #   end

        #   it 'does not delete the user' do
        #     execute

        #     json = JSON.parse(response.body)
        #     data = json.dig('data', 'deleteUser')

        #     expect(data['message']).to be_nil
        #     expect(data['errors']).to eq error_message
        #   end
        # end

        context 'unauthorized' do
          let(:variables) { { userId: unauthorized_user.id } }

          it 'returns error message' do
            execute

            json = JSON.parse(response.body)

            data = json.dig('data', 'deleteUser')
            error_message = json.dig('errors').first['message']

            expect(data).to be_nil
            expect(error_message).to eq 'You are not authorized to perform this action'
          end
        end
      end

      def query_string
        <<~GRAPHQL
          mutation($userId: ID!) {
            deleteUser(input: { userId: $userId }) {
              message
              errors
            }
          }
        GRAPHQL
      end
    end
  end
end
