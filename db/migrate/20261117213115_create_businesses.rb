class CreateBusinesses < ActiveRecord::Migration[8.1]
  def change
    create_table :businesses do |t|
      t.string :name
      t.string :business_type
      t.decimal :monthly_expenses
      t.decimal :default_monthly_fee

      t.timestamps
    end
  end
end
