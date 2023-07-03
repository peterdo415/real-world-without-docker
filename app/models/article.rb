# == Schema Information
#
# Table name: articles
#
#  id          :bigint           not null, primary key
#  body        :text(65535)      not null
#  description :string(255)
#  slug        :string(255)      not null
#  title       :string(255)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer          not null
#
# Indexes
#
#  index_articles_on_title  (title) UNIQUE
#
class Article < ApplicationRecord
  before_save :generate_slug

  validates :title, :body, presence: true
  validates :title, uniqueness: true
  validates :slug, uniqueness: true

  belongs_to :user

  def generate_slug
    self.slug = title.parameterize if title.present?
  end

  def to_json(current_user = user)
    slug = current_user.articles.last.slug
    author = current_user.as_json(only: %i[username bio image])
    { 'article' => as_json({ only: %i[title discription body created_at updated_at] }).merge({ slug: }).merge({ author: }) }
  end
end
