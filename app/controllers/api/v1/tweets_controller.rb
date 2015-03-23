module Api
  module V1
    class TweetsController < APIController

      def index
        tweets = Tweet.bydate
        if tweets
          render json: tweets, status: :ok
        end
      end

      def show
        tweet = Tweet.find(params[:id])
        if tweet
          render json: tweet, status: :ok
        end
      end

      def create
        tweet = Tweet.create!(tweet_params)
        if tweet.save
          render json: tweet, status: 201
        end
      end

      def update
        tweet = Tweet.find(params[:id])
        if tweet.update!(tweet_params)
          render json: tweet, status: :ok
        else
          render json: tweet.errors, status: :unprocessable_entity #422
        end
      end

      def destroy
        Tweet.find(params[:id]).destroy
        head 204
      end

      def like
        tweet = Tweet.find(params[:tweet_id])
        tweet.liked_by(@current_user)
        render :nothing => true
      end

      def dislike
        tweet = Tweet.find(params[:tweet_id])
        tweet.disliked_by(@current_user)
        render :nothing => true
      end

      private
        def tweet_params
          params.require(:tweet).permit(:user_id, :text)
        end

    end
  end
end
