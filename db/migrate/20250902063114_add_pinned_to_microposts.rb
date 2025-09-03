class AddPinnedToMicroposts < ActiveRecord::Migration[7.0]
  def change
    add_column :microposts, :pinned, :boolean, default: false
    add_index :microposts, :pinned
  end
end
