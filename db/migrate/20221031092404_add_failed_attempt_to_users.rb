class AddFailedAttemptToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :failed_attempts, :integer, default: 0
  end
end
