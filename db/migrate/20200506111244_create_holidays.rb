class CreateHolidays < ActiveRecord::Migration[5.2]
  def change
    create_table :holidays do |t|
      t.date :day
      t.integer :kind
    end
  end
end
