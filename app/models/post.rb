class Post < ApplicationRecord
  belongs_to :topic
  has_many :comments, dependent: :destroy
  has_many :posttags, dependent: :destroy
  has_many :tags, through: :posttags
  has_many :ratings, dependent: :destroy
  accepts_nested_attributes_for :tags, reject_if: :all_blank
  has_one_attached :image, dependent: :destroy
  belongs_to :user
  has_and_belongs_to_many :users
  # def Read_status_entry(user)
  #   self.(user.posts).where(post_id: id,user_id: user.id).first_or_create
  # end
  #validations
  validates :name, presence: true
  validates :name, length: { maximum: 20}
  validates :name, uniqueness: {message: "already exists"}
end
