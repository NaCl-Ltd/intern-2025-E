class AddDailyPromptIdToMicroposts < ActiveRecord::Migration[7.0]
  def change
    add_column :microposts, :daily_prompt_id, :integer
    add_index :microposts, :daily_prompt_id
    add_foreign_key :microposts, :daily_prompts 
  end
end
