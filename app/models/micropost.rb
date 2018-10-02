class Micropost < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  scope :search_by_keyword, -> (keyword) {
    where("microposts.content LIKE :keyword",
            keyword: "%#{sanitize_sql_like(keyword)}%") if keyword.present?
  }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate :picture_size

  def like_user(user_id)
    likes.find_by(user_id: user_id)
  end

  private

    # アップロードされた画像のサイズをバリデーション
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end

end
