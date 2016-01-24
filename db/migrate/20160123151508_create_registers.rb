class CreateRegisters < ActiveRecord::Migration
  def change
    create_table :registers do |t|
      t.string :value
      t.string :fetch_data

      t.timestamps null: false
    end
  end
end
