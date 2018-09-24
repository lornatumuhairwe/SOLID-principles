# https://thoughtbot.com/upcase/videos/single-responsibility-principle
# single responsibility principle - A class should have only one reason to change

# Disobeys SRP
class Invitation < ActiveRecord::Base
  EMAIL_REGEX = /\*@*.com/
  STATUSES = %w(pending accepted)

  belongs_to :sender, class_name: 'User'
  belongs_to :survey

  before_create :set_token

  validates :recipient_email, presence: true, format: EMAIL_REGEX
  validates :status, inclusion: { in: STATUSES }

  def to_param
    token
  end

  def deliver
    Mailer.invitation_notification(self).deliver
  end

  private

  def set_token
    self.token = SecureRandom.urlsafe_base64
  end
end


# You could refactor to this and reuse the TokenizeModel class

class Invitation < ActiveRecord::Base
  EMAIL_REGEX = /\*@*.com/
  STATUSES = %w(pending accepted)

  belongs_to :sender, class_name: 'User'
  belongs_to :survey

  validates :recipient_email, presence: true, format: EMAIL_REGEX
  validates :status, inclusion: { in: STATUSES }
end

class TokenizeModel < SimpleDelegator
  def save
    __getobj__.token ||= SecureRandom.urlsafe_base64
    __getobj__.save
  end

  def to_param
    __getobj__.token
  end
end
