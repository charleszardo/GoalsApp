class AddCheersCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :cheers_count, :integer, null: false, default: 12
  end
end
