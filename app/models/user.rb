class User < ApplicationRecord
  VALID_EMAIL_REGEX = Settings.format.email

  before_save :downcase_email

  validates :name, presence: true,
                   length: {maximum: Settings.type_validate.max_length_name}

  validates :email, presence: true,
                    length: {minium: Settings.type_validate.min_length_email, maximum: Settings.type_validate.max_length_email},
                    format: {with: VALID_EMAIL_REGEX},
                    uniqueness: {case_sensitive: false}

  validates :password, presence: true,
                       length: {minimum: Settings.type_validate.min_length_password}, if: :password
  has_secure_password

  private

  def downcase_email
    self.email.downcase!
  end
end
