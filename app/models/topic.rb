class Topic < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, through: :posts, dependent: :destroy
  has_many :ratings, through: :posts, dependent: :destroy
end
