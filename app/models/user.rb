class User < ApplicationRecord
  VALID_EMAIL_REGEX = Settings.format.email
  attr_accessor :remember_token

  before_save :downcase_email

  validates :name, presence: true,
                   length: {maximum: Settings.type_validate.max_length_name}

  validates :email, presence: true,
                    length: {minium: Settings.type_validate.min_length_email, maximum: Settings.type_validate.max_length_email},
                    format: {with: VALID_EMAIL_REGEX},
                    uniqueness: {case_sensitive: false}

  validates :password, presence: true,
                       length: {minimum: Settings.type_validate.min_length_password}, allow_nil: true, if: :password

  scope :ordered_by_name, ->{order name: :asc}
  has_secure_password

  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update remember_digest: User.digest(remember_token)
  end

  def authenticated? attribute, remember_token
    digest = send("#{attribute}_digest")
    return if digest.blank? || !remember_token
    BCrypt::Password.new(remember_digest).is_password? remember_token
  end

  def forget
    update_attribute :remember_digest, nil
  end

  private

  def downcase_email
    self.email.downcase!
  end
end
