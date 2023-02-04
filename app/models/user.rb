class User < ApplicationRecord
  after_create :send_welcome_email
  def send_welcome_email
    # UserMailer.welcome(self).deliver_now
    SignUpMailJob.perform_later(self)
  end
  has_many :posts
  has_many :comments
  has_and_belongs_to_many :posts, join_table: 'posts_users_read_status'


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
