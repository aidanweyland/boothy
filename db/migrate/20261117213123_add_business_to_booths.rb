class AddBusinessToBooths < ActiveRecord::Migration[8.1]
  def change
    add_reference :booths, :business, null: true, foreign_key: true
  end
end