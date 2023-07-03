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
class User < ApplicationRecord
  has_secure_password
  validates :username, :email, :password_digest, presence: true
  validates :username, :email, uniqueness: true

  has_many :articles, dependent: :destroy

  def to_json(token = nil)
    # tokenを引数として受け取り、as_jsonの結果にくっつけるためにこの書き方
    # bio:簡略自己紹介, image:写真
    { 'user' => as_json({ only: %i[email username bio image] }).merge({ token: }) }
  end
end
