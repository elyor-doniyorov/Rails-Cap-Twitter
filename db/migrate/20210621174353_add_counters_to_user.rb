class AddCountersToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :opinion_count, :integer, default: 0
    add_column :users, :count_followers, :integer, :default => 0
    add_column :users, :count_following, :integer, :default => 0
  end
end
