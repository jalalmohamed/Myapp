class Post < ApplicationRecord
  belongs_to :topic
  has_many :comments, dependent: :destroy
  has_many :posttags, dependent: :destroy
  has_many :tags, through: :posttags
  has_many :ratings, dependent: :destroy
  accepts_nested_attributes_for :tags, reject_if: :all_blank
  has_one_attached :image
end
