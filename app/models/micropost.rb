class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image do |attachable|
    attachable.variant :display, resize_to_limit: [500, 500]
  end
  
  default_scope -> { order(created_at: :desc) }
  
   # posts by users that `user` follows
  scope :following, ->(user) { where(user_id: user.following.select(:id)) }

  #last 48h, at most 10
  scope :latest, -> (user){ following(user).order(created_at: :desc).limit(10) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validates :image,   content_type: { in: %w[image/jpeg image/gif image/png],
                                      message: "must be a valid image format" },
                      size:         { less_than: 5.megabytes,
                                      message:   "should be less than 5MB" }
  def can_be_pinned_by?(user)
    user == self.user
  end        
  
  belongs_to :daily_prompt, optional: true

  def is_daily_prompt_response?
    daily_prompt_id.present?
  end

  def daily_prompt_question
    daily_prompt&.send(I18n.locale.to_s) if daily_prompt
  end

  scope :daily_prompt_responses, -> { where.not(daily_prompt_id: nil) }
end
