class CreateRawStats < ActiveRecord::Migration[5.1]
  def change
    create_table :raw_stats do |t|
      t.integer :height
      t.integer :weight
      t.integer :dog_count
      t.integer :cat_count

      t.timestamps
    end
  end
end
