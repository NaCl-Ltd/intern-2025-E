class DailyPrompt < ApplicationRecord
  def self.today_prompt
    today_hash = Date.today.to_s.hash 
    ids = DailyPrompt.pluck(:id)
    selected_id = ids[today_hash % ids.size]
    DailyPrompt.find(selected_id)
  end
end
