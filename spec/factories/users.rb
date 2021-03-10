# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :string
#  first_name :string
#  lastname   :string
#  password   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email)
#
FactoryBot.define do
  factory :user do
    first_name { "MyString" }
    lastname { "MyString" }
    email { "MyString" }
    password { "MyString" }
  end
end
