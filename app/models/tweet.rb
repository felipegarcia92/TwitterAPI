class Tweet < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: true
  validates :text, presence: true

  def liked_by(user)
    UserLikeTweet.create(user_id: user.id, tweet_id: self.id);
  end

  def unliked_by(user)
    like = UserLikeTweet.where(user_id: user.id, tweet_id: self.id)
    like.destroy
  end
end
