class Post < ApplicationRecord
  belongs_to :topic
  has_many :comments, dependent: :destroy
  has_many :posttags, dependent: :destroy
  has_many :tags, through: :posttags
end
