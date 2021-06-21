class CreateFollowings < ActiveRecord::Migration[6.1]
  def change
    create_table :followings do |t|
      t.integer :followerid
      t.integer :followedid

      t.timestamps
    end
  end
end
