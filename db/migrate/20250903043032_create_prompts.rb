class CreatePrompts < ActiveRecord::Migration[7.0]
  def change
    create_table :prompts do |t|
      t.json :translations
      t.timestamps
    end

    add_index :prompts, :created_at
  end
end
