class Following < ApplicationRecord
  belongs_to :follower, foreign_key: 'followerid', class_name: 'User'
  belongs_to :following, foreign_key: 'followedid', class_name: 'User'
end
