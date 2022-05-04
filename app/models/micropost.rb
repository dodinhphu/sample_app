class Micropost < ApplicationRecord
  belongs_to :user
  # default_scope -> {order created_at: :desc}
  scope :recent_posts, -> {order created_at: :desc}
  has_one_attached :image
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: Settings.max_length_content}
  validates :image,
            content_type: { in: Settings.img_type, message: I18n.t("microposts.valid_image_format") },
            size:         { less_than: Settings.size_in_megabytes.megabytes, message: I18n.t("microposts.less_than_5m") }

  def display_image
    image.variant resize_to_limit: Settings.resize_to_limit
  end
end
