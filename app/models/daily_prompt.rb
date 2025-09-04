class DailyPrompt < ApplicationRecord
  def self.today_prompt
    today_hash = Date.today.to_s.hash 
    ids_size = DailyPrompt.pluck(:id).count 
    DailyPrompt.find(today_hash%ids_size)
  end
end
