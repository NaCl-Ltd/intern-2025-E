class UserPromptView < ApplicationRecord
  belongs_to :user
  belongs_to :prompt

  validates :user_id, uniqueness: { scope: :prompt_id }

  before_create :set_viewed_at

  private

  def set_viewed_at
    self.viewed_at ||= Time.current 
  end 
end
