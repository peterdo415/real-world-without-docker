# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  bio             :text(65535)
#  email           :string(255)      not null
#  image           :string(255)
#  password_digest :string(255)      not null
#  username        :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
