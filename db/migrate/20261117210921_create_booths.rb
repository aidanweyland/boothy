class CreateBooths < ActiveRecord::Migration[8.1]
  def change
    create_table :booths do |t|
      t.integer :number
      t.string :vendor_name
      t.decimal :monthly_fee
      t.boolean :occupied

      t.timestamps
    end
  end
end
