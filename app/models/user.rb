class User < ApplicationRecord

  VALID_EMAIL_REGEX = Settings.format.email
  attr_accessor :remember_token, :activation_token, :reset_token
  before_save :downcase_email
  before_create :create_activation_digest

  validate :check_password, on: :update
  has_many :microposts, dependent: :destroy

  has_many :microposts, dependent: :destroy

  has_many :active_relationships, class_name: Relationship.name, foreign_key: :follower_id, dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name, foreign_key: :followed_id, dependent: :destroy

  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

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
    BCrypt::Password.new(digest).is_password? remember_token
  end

  def forget
    update_attribute :remember_digest, nil
  end

  def activate
    update_columns activated: true, activated_at: Time.zone.now
  end

  def send_mail_activate
    UserMailer.account_activation(self).deliver_now
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_columns reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < Settings.time_token.two_h.hours.ago
  end

  def feed
    microposts
  end

  def feed
    Micropost.where user_id: (following_ids << id)
  end

  def follow other_user #Follows a user.
    following << other_user
  end
  def unfollow other_user #Unfollows a user.
    following.delete other_user
  end
  def following? other_user #Returns if the current user is following the other_user or not
    following.include? other_user
  end

  private

  def downcase_email
    self.email.downcase!
  end

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest activation_token
  end

  def check_password
    errors.add :password, I18n.t("forgot_password.alert_not_empty") if self.password.blank?
  end
end
