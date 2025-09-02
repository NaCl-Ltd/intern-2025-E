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
  
  # validation and methhod for pin feature
  validate :only_one_pinned_per_user, if: :pinned?

  # scope to find pinned posts
  scope :pinned, -> { where(pinned: true) }
  scope :not_pinned, -> { where(pinned: false) }

  # method to pint his post (and unpin others)
  def pin!
    # first, unpin any existing pinned posts by this user
    user.microposts.where(pinned: true).update_all(pinned: false)
    # then pin this post
    update!(pinned: true)
  end

  # method to unpin this post
  def unpin!
    update!(pinned: false)
  end

  # check if user can pin this post (must be the owner)
  def can_be_pinned_by?(current_user)
    user == current_user
  end

  private

  # validation to ensure only one pinned post per user
  def only_one_pinned_per_user
    if user.microposts.where(pinned: true).where.not(id: id).exists?
      errors.add(:pinned, "User can only have one pinned post")
    end
  end

end
