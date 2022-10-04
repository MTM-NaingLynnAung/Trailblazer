class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.integer :phone
      t.text :address
      t.date :dob
      t.integer :user_type

      t.timestamps
    end
  end
end
