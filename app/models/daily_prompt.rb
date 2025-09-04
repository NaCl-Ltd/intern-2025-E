class DailyPrompt < ApplicationRecord
  has_many :microposts, dependent: :nullify

  def self.today_prompt
    today_hash = Date.today.to_s.hash 
    ids = DailyPrompt.pluck(:id)
    selected_id = ids[today_hash % ids.size]
    DailyPrompt.find(selected_id)
  end

  def responses
    microposts.where.not(daily_prompt_id: nil)
  end

  def response_count
    responses.count
  end 
end
