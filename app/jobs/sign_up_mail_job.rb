class SignUpMailJob < ApplicationJob
  queue_as :default
  # SignUpMailJob.perform_later(@user)

  def perform(user)
    UserMailer.welcome(user).deliver_now
  end
end
