class Tweet < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: true
  validates :text, presence: true

  has_many :user_like_tweets

  def liked_by(user)
    user_like_tweets.create(user_id: user.id) unless user_like_tweets.exist? user_id: user_id
  end

  def unliked_by(user)
    like = UserLikeTweet.where(user_id: user.id, tweet_id: self.id)
    if like.present?
      like.destroy
    end
  end
end
