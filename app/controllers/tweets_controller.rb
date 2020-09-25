class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all.order("created_at DESC LIMIT 20")
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
      if @tweet.save 
       redirect_to tweets_path, notice: 'Tweet was successfully updated.' 
      else
        str = "Tweet not saved!"
        new_line = "<br/>"
        @tweet.errors.full_messages.each do |msg|
          str << new_line
          str << msg
        end
        respond_to do |format|
          format.html { redirect_to tweets_path, alert: str}
        end
      end
  end

  def edit
    
  end

  def show
    @tweet = Tweet.find(params[:id])
  end

  def tweet_params
    params.permit(:tweet)
  end
end
