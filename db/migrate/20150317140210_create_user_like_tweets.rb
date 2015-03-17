class CreateUserLikeTweets < ActiveRecord::Migration
  def change
    create_table :user_like_tweets do |t|
      t.integer :user_id
      t.integer :tweet_id

      t.timestamps null: false
    end
  end
end
