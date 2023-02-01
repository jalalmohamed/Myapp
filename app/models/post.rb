class Post < ApplicationRecord
  belongs_to :topic
  has_many :comments, dependent: :destroy
  has_many :posttags, dependent: :destroy
  has_many :tags, through: :posttags
  has_many :ratings, dependent: :destroy
  accepts_nested_attributes_for :tags, reject_if: :all_blank
  has_one_attached :image, dependent: :destroy
  belongs_to :user
  has_and_belongs_to_many :users, join_table: 'posts_users_read_status'

  scope :date_between,->(start_date,end_date) { where(created_at: start_date..end_date)}
  #validations
  validates :name, presence: true
  validates :name, length: { maximum: 20}
  validates :name, uniqueness: {message: "already exists"}

end
