class Tag < ApplicationRecord
  has_many :posttags, dependent: :destroy
  has_many :posts, through: :posttags
end
