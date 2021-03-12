# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string
#  first_name      :string
#  last_name       :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email)
#

RSpec.describe User, type: :model do
  it { should have_secure_password }
  it { should validate_presence_of :email }
  it { should validate_uniqueness_of :email }
  it { should allow_value('test@example.com').for :email }
  it { should_not allow_value('test').for :email }
  it { should_not allow_value('@example').for :email }

  include ActiveSupport::Testing::TimeHelpers

  describe '.generate_token' do
    let(:user) { build_stubbed(:user) }
    let(:key) { Rails.application.secrets.secret_key_base }

    it 'returns a JWT with valid claims' do
      token = user.generate_token

      claims = JWT.decode(token, key).first
      freeze_time

      expect(claims['id']).to eq user.id
      expect(claims['exp']).to eq 30.days.from_now.to_i
    end
  end
end
