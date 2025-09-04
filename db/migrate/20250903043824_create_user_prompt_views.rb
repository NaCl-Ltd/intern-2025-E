class CreateUserPromptViews < ActiveRecord::Migration[7.0]
  def change
    create_table :user_prompt_views do |t|
      t.references :user, null: false, foreign_key: true
      t.references :prompt, null: false, foreign_key: true
      t.datetime :viewed_at

      t.timestamps
    end

    add_index :user_prompt_views, [:user_id, :prompt_id], unique: true
    add_index :user_prompt_views, :viewed_at
  end
end
