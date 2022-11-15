class CreateHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :histories do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.boolean :privacy
      t.date :public_schedule
      t.date :private_schedule
      t.timestamps
    end
  end
end
