class AddScheduleToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :public_schedule, :date
    add_column :posts, :private_schedule, :date
  end
end
