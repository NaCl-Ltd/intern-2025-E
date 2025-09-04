class Prompt < ApplicationRecord
  has_many :user_prompt_views, dependent: :destroy
  has_many :users, through: :user_prompt_views

  validates :translations, presence: true

  def text_for_locale(locale = 'en')
    translations&.dig(locale.to_s) || translations&.dig('en') || 'No translation available'
  end

  def available_locales
    translations&.keys&.map(&:to_s) || []
  end

  def has_translation?(locale)
    available_locales.include?(locale.to_s)
  end

  # get today's daily prompt (same for all users) 
  def self.daily_prompt 
    Rails.cache.fetch("daily_prompt_#{Date.current}", expires_in: 24.hours) do
    # Return nil if no prompts exist
    return nil if count == 0  
    
    # weighted random: prompts not used recently have higher weight
      recent_daily_prompts = Rails.cache.read('recent_daily_prompts') || []
      available_prompts = where.not(id: recent_daily_prompts)

      if available_prompts.empty?
        #Reset if all prompts have been used recently
        Rails.cache.delete('recent_daily_prompts')
        available_prompts = all
      end

      selected = available_prompts.sample
      return nil unless selected #safety check

      # track recent daily prompts (keep last 10)
      recent_daily_prompts = (recent_daily_prompts + [selected.id]).last(10)
      Rails.cache.write('recent_daily_prompts', recent_daily_prompts)

      selected
    end
  end

end
