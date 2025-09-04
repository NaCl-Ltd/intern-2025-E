class CreateDailyPrompts < ActiveRecord::Migration[7.0]
  def change
    create_table :daily_prompts do |t|
      t.text :en
      t.text :ja

      t.timestamps
    end
  end
end
