class CreateSpaces < ActiveRecord::Migration[8.1]
  def change
    create_table :spaces do |t|
      t.string :name
      t.string :space_type
      t.text :description
      t.decimal :daily_rate
      t.boolean :available

      t.timestamps
    end
  end
end
