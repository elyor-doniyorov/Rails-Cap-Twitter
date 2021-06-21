class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 15 }
  validates :fullname, presence: true
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :opinions, foreign_key: 'author_id'

  has_many :likes, dependent: :destroy

  has_many :followers, foreign_key: :followerid, class_name: 'Following'
  has_many :user_followers, through: :followers, source: :follower

  has_many :followings, foreign_key: :followedid, class_name: 'Following'
  has_many :user_followings, through: :followings, source: :following
  scope :all_tweet, -> { includes(:user_followers, :user_followings, :opinions) }

  def not_following
    User.all.where.not(id: user_followings.select(:id)).where.not(id: id).order(created_at: :desc)
  end

  def self.followers(id, curr_user_id)
    Following.where(followedid: id).where.not(followerid: curr_user_id).order(created_at: :desc).limit(5)
  end

  def already_follow?(user_id)
    true if Following.find_by(followerid: id, followedid: user_id)
  end

  def follow_user(user_id)
    @follow = Following.create(followerid: id, followedid: user_id)
    @user = User.find(user_id)
    @user.count_following += 1
    self.count_followers += 1
    @user.save
    save
  end
end
