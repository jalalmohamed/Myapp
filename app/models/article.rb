class Article < ApplicationRecord
  has_many :insides, dependent: :destroy
  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }
end
