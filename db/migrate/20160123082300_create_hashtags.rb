class CreateHashtags < ActiveRecord::Migration
  def change
    create_table :hashtags do |t|
      t.string :value
      t.integer :comment_id

      t.timestamps null: false
    end
  end
end
