class TweetsController < ApplicationController
  before_action :set_tweeet, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    if user_signed_in?
      @tweets = Tweet.all.order("created_at DESC LIMIT 20")
    else
      redirect_to new_user_session_path
    end
  end

  def new
    @tweet = current_user.tweets.build
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)
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
