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
require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
